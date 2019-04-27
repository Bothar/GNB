import Foundation

final class CurrencyNode {
    
    let value: Currency
    
    private(set) weak var parent: CurrencyNode?
    private(set) var children: [CurrencyNode] = []
    
    init(value: Currency) {
        self.value = value
    }
    
    private func addChild(node: CurrencyNode) {
        children.append(node)
        node.parent = self
    }
    
    func checkChilds(fromRates rates: [Rate]) {
        rates
            .filter { (rate) -> Bool in
                return rate.to == value
            }
            .forEach { (rate) in
                if let from = rate.from {
                    let newNode = CurrencyNode(value: from)
                    //Removing the rate added in both ways: ie (EU, USD) and (USD, EU)
                    let newRates = rates.filter({ ($0 != rate) && !($0.from == value && $0.to == from)})
                    newNode.checkChilds(fromRates: newRates)
                    addChild(node: newNode)
                }
        }
    }
}

extension CurrencyNode: Equatable {
    static func == (lhs: CurrencyNode, rhs: CurrencyNode) -> Bool {
        return lhs.value == rhs.value && lhs.parent == rhs.parent && lhs.children == rhs.children
    }
}
