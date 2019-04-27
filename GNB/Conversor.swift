import Foundation

class Conversor {
    
    static let sharedInstance = Conversor()
    
    private init() {}
    
    private var rootTransactionTree: CurrencyNode?
    
    private var rates: [Rate]? {
        didSet {
            createTree(fromRates: rates)
        }
    }
    
    private func createTree(fromRates rates: [Rate]?) {
        guard let rates = rates else {return}
        rootTransactionTree = CurrencyNode(value: .EUR)
        rootTransactionTree?.checkChilds(fromRates: rates)
    }
    
    private func backTrack(fromNode node: CurrencyNode, path: [Currency]) -> [Currency] {
        var newPath = path
        newPath.append(node.value)
        if let parent = node.parent {
            return backTrack(fromNode: parent, path: newPath)
        }
        return newPath
    }
    
    private func findDFSPath(from: Currency) -> [Currency]? {
        guard let rootTransactionTree = rootTransactionTree else {return nil}
        var visitedNodes = [CurrencyNode]()
        let stackNodes = Stack(fromArray: [rootTransactionTree])
        
        while !stackNodes.isEmpy {
            if let node = stackNodes.pop(),
                !visitedNodes.contains(node) {
                visitedNodes.append(node)

                if (node.value == from) {
                    //backtracking the path
                    return backTrack(fromNode: node, path: [])
                }
                
                node.children.forEach { (neighbourNode) in
                    stackNodes.push(elemToPush: neighbourNode)
                }
            }
        }
        return nil
    }
    
    func convertToEuro(transaction: Transaction) -> NSDecimalNumber? {
        guard let rates = rates,
            let amount = transaction.amountNumber,
            let currency = transaction.currency,
            let pathToEuro = findDFSPath(from: currency),
            pathToEuro.count >= 2 else {return nil}
        
        var value = amount.rounding(accordingToBehavior: NSDecimalNumberHandler(roundingMode: .bankers, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false))
        
        for index in 0...pathToEuro.count - 2 {
            let ratesToApply = rates.filter { (rate) -> Bool in
                return rate.from == pathToEuro[index] && rate.to == pathToEuro[index+1]
            }
            
            if let rateToApply = ratesToApply.first,
                let changeValue = rateToApply.rateNumber {
                value = value.multiplying(by: changeValue)
                .rounding(accordingToBehavior: NSDecimalNumberHandler(roundingMode: .bankers, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false))
            }
            
        }
        return value
    }
    
    func setRates(_ rates: [Rate]) {
        self.rates = rates
    }
    
}
