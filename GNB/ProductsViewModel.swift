import Foundation

class ProductsViewModel {
    private let dataSource = ProductsDataSource()
    
    var numberOfProducts: Int {
        return dataSource.productsList?.count ?? 0
    }
    
    func requestTransactions(delegate: NetworkDelegate) {
        dataSource.requestTransactions(delegate: delegate)
    }
    
    func requestRates(delegate: NetworkDelegate) {
        dataSource.requestRates(delegate: delegate)
    }
    
    func transactions(ofProduct productSku: String) -> [Transaction] {
        return dataSource.transactions?.filter({ (transaction) -> Bool in
            return transaction.sku == productSku
        }) ?? []
    }
    
    func productName(atIndex index: Int) -> String? {
        guard let productsList = dataSource.productsList,
            productsList.indices.contains(index) else {return nil}
        return productsList[index]
    }
}
