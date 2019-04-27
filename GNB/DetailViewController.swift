import UIKit

class DetailViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var totalSumLabel: UILabel!
    
    static func instantiateVC(withTransactions transactions: [Transaction]) -> DetailViewController? {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        let viewModel = DetailViewModel(transactions: transactions)
        vc?.viewModel = viewModel
        return vc
    }
    
    var viewModel: DetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else {return}
        
        self.tableView.reloadData()
        self.setTitleNavigationBar(title: viewModel.navigationTitle)
        
        totalSumLabel.text = viewModel.totalSumText
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfTransactions ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let transaction = viewModel?.transaction(atIndex: indexPath.row),
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as? DetailTableViewCell else {
                return UITableViewCell()
        }
        if let amount = transaction.amountNumber,
            let currency = transaction.currency {
            cell.amountLabel.text = "\(amount)"
            cell.currencyLabel.text = currency.rawValue
        }
        return cell
    }
}
