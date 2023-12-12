import UIKit

class AlertManager {
    static let shared = AlertManager()
    
    private init() {}
    
    func showAlert(title: String = TitleForUI.alert.text, viewController: UIViewController?) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        viewController?.present(alertController, animated: true, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    func showConfirmationAlert(title: String = TitleForUI.alert.text, message: String = TitleForUI.message.text,  viewController: UIViewController, completion: @escaping Handler) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: TitleForUI.cancel.text, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let confirmAction = UIAlertAction(title:  TitleForUI.confirm.text, style: .default) { _ in
            completion()
        }
        alertController.addAction(confirmAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithTextField(title: String = TitleForUI.alert.text, message: String? = nil, viewController: UIViewController, completion: @escaping StringClosure) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = TitleForUI.placeholder.text
        }
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            guard let textField = alertController?.textFields?.first,
                  let enteredText = textField.text,
                  !enteredText.isEmpty else { return }
                completion(enteredText)
        }
        
        let cancelAction = UIAlertAction(title: TitleForUI.cancel.text, style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
