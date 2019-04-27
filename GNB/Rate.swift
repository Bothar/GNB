import Foundation

class Rate: Codable {
    var from: Currency?
    var to: Currency?
    private var rate: String?
    
    var rateNumber: NSDecimalNumber? {
        return NSDecimalNumber(string: rate)
    }
    
    init(from: Currency, to: Currency, rate: String) {
        self.from = from
        self.to = to
        self.rate = rate
    }
}

extension Rate: Equatable {
    static func == (lhs: Rate, rhs: Rate) -> Bool {
        return lhs.from == rhs.from && lhs.to == rhs.to
    }
}
