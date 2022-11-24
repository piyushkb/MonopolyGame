
import UIKit
import Lottie

class RailRoadVC: UIViewController {

    var player:Player!
    var buyAmount = 0
    
    var titleText = ""
    var descriptionText = ""
    var alreadyOwned = false
    var completionHandler:(() -> Void)?
    
   @IBOutlet weak var lottieAnimatoinView: LottieAnimationView!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var cardTitle: UILabel!

    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var cardDescription: UILabel!
   
   override func viewDidLoad() {
       
       self.view.viewWithTag(12)!.dropShadow()
       self.view.viewWithTag(12)!.cornerRadius = 10
       
       
       self.playAnimation(json: AnimationJson.Rail)
       playSound(soundName: "card")
       
       self.cardTitle.text = self.titleText
       self.cardDescription.text = self.descriptionText
       
       self.buyButton.isHidden = alreadyOwned
       
   }
    
    
   
   
   @IBAction func onBuy(_ sender: Any) {
       
       let haveEnaughMoney = LogicsHandler.shared.haveMoneyToBuy(player: player, buyAmount: buyAmount)
       
       if(!haveEnaughMoney) { // okaat nhi bachi kharidne ke
           showErrorBanner(message: "You don't have enaugh Money to Buy")
           self.dismiss(animated: true)
       }else {
           if let completionHandler =  completionHandler{
               completionHandler()
           }
           self.dismiss(animated: true)
       }
   }
   
   @IBAction func onExit(_ sender: Any) {
       
       if(alreadyOwned) {
           
           self.dismiss(animated: true)
           
           if let completionHandler =  completionHandler{
               completionHandler()
           }
       }else {
           self.dismiss(animated: true)
       }
     
   }
   
   
   func playAnimation(json:String) {
       
       lottieAnimatoinView.animation = LottieAnimation.named(json)
       lottieAnimatoinView.loopMode = .loop
       lottieAnimatoinView.contentMode = .scaleAspectFit
       lottieAnimatoinView.play()
   }
   
}
