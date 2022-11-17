 
import UIKit
import Lottie
class ChanceVC: UIViewController {

    var chanceIsGood = true
    let closeIn = 7.0
    @IBOutlet weak var chanceLabel: UILabel!
    
    @IBOutlet weak var lottieAnimatoinView: LottieAnimationView!
    
    @IBAction func onClose(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        
        self.view.viewWithTag(12)!.dropShadow()
        self.view.viewWithTag(12)!.cornerRadius = 30
        
        DispatchQueue.main.asyncAfter(deadline: .now() + closeIn) {
            self.dismiss(animated: true)
        }
        
        if(chanceIsGood) {
            self.playAnimation(json: AnimationJson.Star)
        }else {
            
        }
        
    }
    
    
    func playAnimation(json:String) {
        
        lottieAnimatoinView.animation = LottieAnimation.named(json)
        lottieAnimatoinView.loopMode = .playOnce
        lottieAnimatoinView.contentMode = .scaleAspectFill
        lottieAnimatoinView.play()
    }
    

}
