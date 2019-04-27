import Foundation

class Transaction: Codable {
    var sku: String?
    private var amount: String?
    var currency: Currency?
    
    var amountNumber: NSDecimalNumber? {
        return NSDecimalNumber(string: amount)
    }
    
    init(sku: String, amount: String, currency: Currency) {
        self.sku = sku
        self.amount = amount
        self.currency = currency
    }
}
