
import UIKit
import Lottie

class UtilityVC: UIViewController {

    var titleText = ""
    var descriptionText = ""
    var lottieAnimationName = ""
    var completionHandler:(() -> Void)?
    
   @IBOutlet weak var lottieAnimatoinView: LottieAnimationView!
 
   @IBOutlet weak var cardTitle: UILabel!
   
   @IBOutlet weak var cardDescription: UILabel!
   
   override func viewDidLoad() {
       
       DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
           self.dismiss(animated: true)
       }
       
       self.view.viewWithTag(12)!.dropShadow()
       self.view.viewWithTag(12)!.cornerRadius = 10
       
       
       self.playAnimation(json: lottieAnimationName)
       
       playSound(soundName: "card")
       
       self.cardTitle.text = titleText
       
       self.cardDescription.text = descriptionText
   }
   
    override func viewDidDisappear(_ animated: Bool) {
        if let completionHandler =  completionHandler{
            completionHandler()
        }
    }
   
   @IBAction func onExit(_ sender: Any) {
       self.dismiss(animated: true)
   }
   
   
   func playAnimation(json:String) {
       
       lottieAnimatoinView.animation = LottieAnimation.named(json)
       lottieAnimatoinView.loopMode = .loop
       lottieAnimatoinView.contentMode = .scaleAspectFit
       lottieAnimatoinView.play()
   }
   
}
