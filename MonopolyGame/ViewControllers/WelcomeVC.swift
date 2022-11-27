 
import UIKit
import Lottie

class WelcomeVC: UIViewController {
    
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var animationButton: LottieAnimationView!
    
    override func viewDidLoad() {
        animationView.animation = LottieAnimation.named(AnimationJson.Splash)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationButton.animation = LottieAnimation.named(AnimationJson.LetsGo)
        animationButton.loopMode = .loop
        animationButton.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        animationButton.stop()
        animationButton.play()
        animationView.stop()
        animationView.play()
        
        playSound(soundName: AnimationJson.Splash,repat: -1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let  player = player {
            player.stop()
        }
    }
}
