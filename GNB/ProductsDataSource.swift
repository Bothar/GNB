import Foundation
import Alamofire

class ProductsDataSource {
    
    static let kTransactionsId = "ProductsDataSourceTransactions"
    static let kRatesId = "ProductsDataSourceRates"
    
    private(set) var transactions: [Transaction]?
    private(set) var productsList: [String]?
    
    func requestTransactions(delegate: NetworkDelegate) {
        
        delegate.startLoading(ProductsDataSource.kTransactionsId)
        
        Alamofire.request(Constants.kAPI_BASE_URL+Constants.kAPI_TRANSACTIONS_URL, method: .get, parameters: [:], encoding: URLEncoding.default).validate(contentType: ["application/json"])
            .responseJSON { [weak self, weak delegate] response in
            switch response.result {
            case .success(let JSON):
                guard let JSON = JSON as? [[String: Any]] else {return}
                self?.transactions = []
                JSON.forEach({ jsonTransaction in
                    if  let transactionData = try? JSONSerialization.data(withJSONObject: jsonTransaction),
                        let transaction = try? JSONDecoder().decode(Transaction.self, from: transactionData) {
                        self?.transactions?.append(transaction)
                    }
                })
                
                self?.productsList = self?.transactions?.compactMap({ (transaction) -> String? in
                    return transaction.sku
                }).removeDuplicates()
                
                delegate?.stopLoadingWithSucces(ProductsDataSource.kTransactionsId)
            case .failure(let error):
                delegate?.stopLoadingWithError(ProductsDataSource.kTransactionsId, error: error)
            }
        }
    }
    
    func requestRates(delegate: NetworkDelegate) {
        
        delegate.startLoading(ProductsDataSource.kRatesId)
        
        Alamofire.request(Constants.kAPI_BASE_URL+Constants.kAPI_RATES_URL, method: .get, parameters: [:], encoding: URLEncoding.default).validate(contentType: ["application/json"])
            .responseJSON { [weak delegate] response in
            switch response.result {
            case .success(let JSON):
                guard let JSON = JSON as? [[String: Any]] else {return}
                var rates: [Rate] = []
                JSON.forEach({ jsonRate in
                    if  let rateData = try? JSONSerialization.data(withJSONObject: jsonRate),
                        let rate = try? JSONDecoder().decode(Rate.self, from: rateData) {
                        rates.append(rate)
                    }
                })
                Conversor.sharedInstance.setRates(rates)
                delegate?.stopLoadingWithSucces(ProductsDataSource.kRatesId)
            case .failure(let error):
                delegate?.stopLoadingWithError(ProductsDataSource.kRatesId, error: error)
            }
        }
    }
}
