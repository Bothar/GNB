
import XCTest
@testable import GNB

class GNBConversorTest: XCTestCase {
    
    func testDirectConversion() {
        
        let mockedRates = [
            Rate(from: .USD, to: .EUR, rate: "0.65"),
            Rate(from: .EUR, to: .USD, rate: "1.54"),
            Rate(from: .CAD, to: .EUR, rate: "1.48"),
            Rate(from: .EUR, to: .CAD, rate: "0.68"),
            Rate(from: .AUD, to: .USD, rate: "1.36"),
            Rate(from: .USD, to: .AUD, rate: "0.74")
        ]
        
        let mockedTransaction = Transaction(sku: "asd", amount: "100", currency: .USD)
        
        let expectedEuroValue = NSDecimalNumber(65)
        
        let conversor = Conversor.sharedInstance
        
        conversor.setRates(mockedRates)

        let euroValue = conversor.convertToEuro(transaction: mockedTransaction)
        
        XCTAssertEqual(euroValue, expectedEuroValue)
    }
    
    func testDerivedConversion() {
        
        let mockedRates = [
            Rate(from: .USD, to: .EUR, rate: "0.65"),
            Rate(from: .EUR, to: .USD, rate: "1.54"),
            Rate(from: .CAD, to: .EUR, rate: "1.48"),
            Rate(from: .EUR, to: .CAD, rate: "0.68"),
            Rate(from: .AUD, to: .USD, rate: "1.36"),
            Rate(from: .USD, to: .AUD, rate: "0.74")
        ]
        
        let mockedTransaction = Transaction(sku: "asd", amount: "100", currency: .AUD)
        
        let expectedEuroValue = NSDecimalNumber(88.4)
        
        let conversor = Conversor.sharedInstance
        
        conversor.setRates(mockedRates)
        
        let euroValue = conversor.convertToEuro(transaction: mockedTransaction)
        
        XCTAssertEqual(euroValue, expectedEuroValue)
    }
    
    func testDerivedConversion2() {
        
        let mockedRates = [
            Rate(from: .USD, to: .AUD, rate: "0.65"),
            Rate(from: .AUD, to: .USD, rate: "1.54"),
            Rate(from: .USD, to: .EUR, rate: "1.48"),
            Rate(from: .EUR, to: .USD, rate: "0.68"),
            Rate(from: .AUD, to: .CAD, rate: "1.36"),
            Rate(from: .CAD, to: .AUD, rate: "0.74")
        ]
        
        let mockedTransaction = Transaction(sku: "asd", amount: "100", currency: .CAD)
        
        let expectedEuroValue = NSDecimalNumber(168.66)
        
        let conversor = Conversor.sharedInstance
        
        conversor.setRates(mockedRates)
        
        let euroValue = conversor.convertToEuro(transaction: mockedTransaction)
        
        XCTAssertEqual(euroValue, expectedEuroValue)
    }
    
    
    func testTotalSum() {
        
        let mockedRates = [
            Rate(from: .USD, to: .AUD, rate: "0.65"),
            Rate(from: .AUD, to: .USD, rate: "1.54"),
            Rate(from: .USD, to: .EUR, rate: "1.48"),
            Rate(from: .EUR, to: .USD, rate: "0.68"),
            Rate(from: .AUD, to: .CAD, rate: "1.36"),
            Rate(from: .CAD, to: .AUD, rate: "0.74")
        ]
        
        let mockedTransactions = [
            Transaction(sku: "asd", amount: "10", currency: .EUR),
            Transaction(sku: "asd", amount: "10", currency: .USD),
            Transaction(sku: "asd", amount: "10", currency: .AUD),
            Transaction(sku: "asd", amount: "10", currency: .CAD)
        ]
        
        let expectedResult = NSDecimalNumber(string: "64.46")
        
        let conversor = Conversor.sharedInstance
        
        conversor.setRates(mockedRates)
        
        let dataSource = DetailDataSource()
        
        let euroValue = dataSource.getTotalSum(fromTransactions: mockedTransactions)
        
        XCTAssertEqual(euroValue, expectedResult)
    }
       
}


