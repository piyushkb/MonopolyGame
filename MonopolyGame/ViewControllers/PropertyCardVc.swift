
import UIKit
import Lottie

class PropertyCardVc: UIViewController {

    var player:Player!
    var space : PlayerSpace!
    var completionHandler:((String) -> Void)?
    var card : PropertyCard!
    @IBOutlet weak var lottieAnimatoinView: LottieAnimationView!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var cardDescription: UILabel!
   
   override func viewDidLoad() {
       
       self.view.viewWithTag(12)!.dropShadow()
       self.view.viewWithTag(12)!.cornerRadius = 10
       
       
       self.playAnimation(json: AnimationJson.Property)
       playSound(soundName: AnimationJson.Property)
   
       self.setData()
       
//       self.cardTitle.text = self.titleText
//       self.cardDescription.text = self.descriptionText
//
//       self.buyButton.isHidden = alreadyOwned
       
   }
    
    func setData() {
        
        self.card = getPropertyCard(space: space)
        self.cardTitle.text = "\n" + card.name + "\n"
        self.cardDescription.text = card.getDescription()
        self.cardTitle.backgroundColor = card.getColor()
        self.buyButton.isHidden = player.assets.alreadyOwned(space: self.space)
    }
    
 
   @IBAction func onBuy(_ sender: Any) {
      
       let haveEnoughMoney = LogicsHandler.shared.haveMoneyToBuy(player: player, spendingAmount: card.getPriceInt())

       let haveAssets = LogicsHandler.shared.haveAssets(player:player)

       if(!haveEnoughMoney) {
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
           if let completionHandler = completionHandler{
               completionHandler("Buy")
           }
           self.dismiss(animated: true)
       }
   }
   
   @IBAction func onExit(_ sender: Any) {
       
       if let completionHandler = completionHandler{
           completionHandler("Exit")
       }
       self.dismiss(animated: true)
        
   }
   
   
   func playAnimation(json:String) {
       
       lottieAnimatoinView.animation = LottieAnimation.named(json)
       lottieAnimatoinView.loopMode = .loop
       lottieAnimatoinView.contentMode = .scaleAspectFit
       lottieAnimatoinView.play()
   }
   
}
