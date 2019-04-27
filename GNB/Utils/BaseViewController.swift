import UIKit

class BaseViewController: UIViewController, NetworkDelegate {
   
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setTitleNavigationBar(title: String) {
        self.navigationItem.title = title
    }
    
    func startActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }
    
    func startLoading(_ idRequest: String) {}
    
    func stopLoadingWithSucces(_ idRequest: String) {}
    
    func stopLoadingWithError(_ idRequest: String, error: Error) {
        AlertView.showAlert(view: self, title: .ERTitle, message: error.localizedDescription, buttonOk: .EROkButtok)
    }
    
}
