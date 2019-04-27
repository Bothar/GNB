import UIKit

class AlertView {
    
    class func showAlert(view: UIViewController, title: String,  message: String, buttonOk: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonOk, style: .default, handler: nil))
        
        DispatchQueue.main.async {
            view.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showAlert(view: UIViewController, title: String,  message: String, buttonOk: String, completion: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonOk, style: .default, handler: completion))
        
        DispatchQueue.main.async {
            view.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showAlert(view: UIViewController, title: String,  message: String, buttonOk: String, buttonCancel: String, completion:@escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonOk, style: .default, handler: completion))
        alert.addAction(UIAlertAction(title: buttonCancel, style: .default, handler: completion))
        
        DispatchQueue.main.async {
            view.present(alert, animated: true, completion: nil)
        }
    }
}
