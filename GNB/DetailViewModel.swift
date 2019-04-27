import Foundation

class DetailViewModel {
    private let dataSource = DetailDataSource()
    private let transactions: [Transaction]
    
    init(transactions: [Transaction]) {
        self.transactions = transactions
    }
    
    var numberOfTransactions: Int {
        return transactions.count
    }
    
    func transaction(atIndex index: Int) -> Transaction? {
        guard transactions.indices.contains(index) else {return nil}
        return transactions[index]
    }
    
    
    var navigationTitle: String {
        return transactions.first?.sku ?? ""
    }
    
    var totalSumText: String {
        let value = dataSource.getTotalSum(fromTransactions: transactions)
        return .DVTotal + " \(value) \(Currency.EUR)"
    }
}
