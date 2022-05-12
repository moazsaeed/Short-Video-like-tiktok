//
//  Created by Moaz Saeed
//

import UIKit
import KRProgressHUD

extension UIViewController: StoryboardCreatable {
    
    @objc class var storyboard: UIStoryboard {
        let name = Self.storyboardName
        let bundle = Self.storyboardBundle
        return UIStoryboard(name: name, bundle: bundle)
    }
    
    @objc class var storyboardBundle: Bundle? {
        return Bundle(for: self)
    }
    
    @objc class var storyboardName: String {
        return "Main"
    }
    
    @objc class var storyboardIdentifier: String {
        return "\(self)"
    }
    
    @objc final class func instanceFromStoryboard() -> Self {
        let storyboardViewController = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier)
        guard let viewController = storyboardViewController as? Self else {
            fatalError(
                "View controller on storyboard named \(storyboardName) " +
                    "was expected to be an instance of type \(type(of: self)), " +
                    "but it's actually an instance of \(type(of: storyboardViewController)). " +
                    "Fix the type in the storyboard and/or overrride `storyboardIdentifier` with the right value")
        }
        return viewController
    }
    
    func showAlert(title: String, message: String, dismissBtnTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    func showLoading(){
        KRProgressHUD.show()
    }
    
    func hideLoading(){
        KRProgressHUD.dismiss()
    }
}
