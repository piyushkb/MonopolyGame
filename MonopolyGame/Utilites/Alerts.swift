 
import UIKit


func showAlertAnyWhere(message:String){
   DispatchQueue.main.async {
   let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
   let action = UIAlertAction(title: "Ok", style: .default) { (alert) in
      // completion?(true)
   }
   alert.addAction(action)
   UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
   }
}

func showConfirmationAlertGlobal(noText:String = "No",message:String,completion:@escaping (Bool) -> Void){
   DispatchQueue.main.async {
   let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
   let yesAction = UIAlertAction(title: "Yes", style: .default) { (alert) in
       completion(true)
   }
   let noAction = UIAlertAction(title: noText, style: .default) { (alert) in
           completion(false)
   }
   alert.addAction(yesAction)
   alert.addAction(noAction)
       
  
   UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
   }
}

func showOkeyAlertWithCallBackAnyWhere(message:String,completion:@escaping () -> Void){
   DispatchQueue.main.async {
   let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
   let okeyAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
       completion()
   }
   
   alert.addAction(okeyAction)
  
   UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
   }
}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
