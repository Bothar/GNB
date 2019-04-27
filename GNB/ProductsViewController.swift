import UIKit

class ProductsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    let viewModel = ProductsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestRates(delegate: self)
        viewModel.requestTransactions(delegate: self)
    }
    
    override func stopLoadingWithSucces(_ idRequest: String) {
        switch idRequest {
        case ProductsDataSource.kTransactionsId:
            tableView.reloadData()
        default:
            return
        }
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productName = viewModel.productName(atIndex: indexPath.row),
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkuTableViewCell") as? SkuTableViewCell else {
            return UITableViewCell()
        }
        
        cell.LabelSku.text = productName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let productSku = viewModel.productName(atIndex: indexPath.row) else {return}
        
        let productTransactions = viewModel.transactions(ofProduct: productSku)
        
        if let vc = DetailViewController.instantiateVC(withTransactions: productTransactions) {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

