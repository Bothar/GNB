import Foundation

class DetailDataSource {
    
    func getTotalSum(fromTransactions transactions: [Transaction]) -> NSDecimalNumber {
        var total = NSDecimalNumber(value: 0)
        transactions.forEach { (transaction) in
            if transaction.currency == .EUR {
                total = total.adding(transaction.amountNumber ?? 0)
            } else {
                if let conversion = Conversor.sharedInstance.convertToEuro(transaction: transaction) {
                    total = total.adding(conversion)
                }
            }
        }
        return total
    }
}
