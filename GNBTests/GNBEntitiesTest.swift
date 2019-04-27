import XCTest
@testable import GNB


class GNBEntitiesTest: XCTestCase {
    
    func testTransactionDecode() {
        let mockedJSON = """
        {
            "sku": "ASD12",
            "currency": "AUD",
            "amount": "22.2"
        }
        """.data(using: .utf8)!
        do {
            let transaction = try JSONDecoder().decode(Transaction.self, from: mockedJSON)
            let expectedAmount = NSDecimalNumber(string: "22.2")
            XCTAssertEqual(transaction.sku, "ASD12")
            XCTAssertEqual(transaction.currency, Currency.AUD)
            XCTAssertEqual(transaction.amountNumber, expectedAmount)
        } catch {
            XCTFail("Json not decoded correctly")
        }
    }
    
    func testRateDecode() {
        let mockedJSON = """
        {
            "from": "EUR",
            "rate": "1.359",
            "to": "USD"
        }
        """.data(using: .utf8)!
        do {
            let rate = try JSONDecoder().decode(Rate.self, from: mockedJSON)
            let expectedRate = NSDecimalNumber(string: "1.359")
            XCTAssertEqual(rate.from, Currency.EUR)
            XCTAssertEqual(rate.rateNumber, expectedRate)
            XCTAssertEqual(rate.to, Currency.USD)
        } catch {
            XCTFail("Json not decoded correctly")
        }
    }
    
    func testCurrencyTreeGenerationSingleChild() {
        let mockedRates = [
            Rate(from: .USD, to: .AUD, rate: "0.65"),
            Rate(from: .AUD, to: .USD, rate: "1.54"),
            Rate(from: .USD, to: .EUR, rate: "1.48"),
            Rate(from: .EUR, to: .USD, rate: "0.68"),
            Rate(from: .AUD, to: .CAD, rate: "1.36"),
            Rate(from: .CAD, to: .AUD, rate: "0.74")
        ]
        
        let rootTransactionTree = CurrencyNode(value: .EUR)
        rootTransactionTree.checkChilds(fromRates: mockedRates)
        XCTAssertEqual(rootTransactionTree.children.count, 1)
        
        let childUSD = rootTransactionTree.children.first
        XCTAssertEqual(childUSD?.value, .USD)
        XCTAssertEqual(childUSD?.children.count, 1)
        
        let childAUD = childUSD?.children.first
        XCTAssertEqual(childAUD?.value, .AUD)
        XCTAssertEqual(childAUD?.children.count, 1)
        
        let childCAD = childAUD?.children.first
        XCTAssertEqual(childCAD?.value, .CAD)
        XCTAssertEqual(childCAD?.children.count, 0)
    }
    
    func testCurrencyTreeGenerationMultipleChild() {
        let mockedRates = [
            Rate(from: .USD, to: .EUR, rate: "0.65"),
            Rate(from: .EUR, to: .USD, rate: "1.54"),
            Rate(from: .CAD, to: .EUR, rate: "1.48"),
            Rate(from: .EUR, to: .CAD, rate: "0.68"),
            Rate(from: .AUD, to: .USD, rate: "1.36"),
            Rate(from: .USD, to: .AUD, rate: "0.74")
        ]
        
        let rootTransactionTree = CurrencyNode(value: .EUR)
        rootTransactionTree.checkChilds(fromRates: mockedRates)
        XCTAssertEqual(rootTransactionTree.children.count, 2)
        
        let childUSD = rootTransactionTree.children.first
        XCTAssertEqual(childUSD?.value, .USD)
        XCTAssertEqual(childUSD?.children.count, 1)
        
        let childCAD = rootTransactionTree.children.last
        XCTAssertEqual(childCAD?.value, .CAD)
        XCTAssertEqual(childCAD?.children.count, 0)
        
        let childAUD = childUSD?.children.first
        XCTAssertEqual(childAUD?.value, .AUD)
        XCTAssertEqual(childAUD?.children.count, 0)
    }
}

