
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
       
       let haveEnaughMoney = LogicsHandler.shared.haveMoneyToBuy(player: player, spendingAmount: buyAmount)
       
       let haveAssets = LogicsHandler.shared.haveAssets(player: player)
       
       if(!haveEnaughMoney) {
           // okaat nhi bachi kharidne ke
           
           if(haveAssets) {
               let msg = "You don't have enough Money to Buy, Would you like to sell your assets?"
               showConfirmationAlertGlobal(message: msg) { value in
                   
                   if value {
                       let vc = self.storyboard?.instantiateViewController(withIdentifier: "AssetsVC") as! AssetsVC
                       vc.player = self.player
                       vc.modalTransitionStyle = .coverVertical
                       vc.modalPresentationStyle = .overCurrentContext
                       self.present(vc, animated: true)
                   }else{
                      // self.dismiss(animated: true)
                   }
               }
           }else {
               showAlertAnyWhere(message: "You don't have Enough Money to buy")
               return
           }

        
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
