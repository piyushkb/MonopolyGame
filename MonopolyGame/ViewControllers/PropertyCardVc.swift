 
import UIKit
import Lottie

class PropertyCardVc: UIViewController {

    @IBOutlet weak var lottieAnimatoinView: LottieAnimationView!
  
    @IBOutlet weak var cardTitle: UILabel!
    
    @IBOutlet weak var cardSubTitle: UILabel!
    
    @IBOutlet weak var cardDescription: UILabel!
    
    override func viewDidLoad() {
        
        self.view.viewWithTag(12)!.dropShadow()
        self.view.viewWithTag(12)!.cornerRadius = 10
        
        
        self.playAnimation(json: AnimationJson.Chance)
        playSound(soundName: "card")
        
        self.cardTitle.text = "\n" +  "Mumbai"
        
        self.cardSubTitle.text = "Chhatrapati Shivaji Maharaj International Airport" + "\n"
    }
    
    
    @IBAction func onBuy(_ sender: Any) {
        
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
