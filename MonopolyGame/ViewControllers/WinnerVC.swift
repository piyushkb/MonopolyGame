 
import UIKit
import Lottie

class WinnerVC : UIViewController {
    
    var player:Player!
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var bigAnimationView: LottieAnimationView!
    @IBOutlet weak var smallAnimationView: LottieAnimationView!
    
    override func viewDidLoad() {
        
        self.winnerLabel.text = "\(player.playerName) \n Won This Game."
        playSound(soundName: AnimationJson.Win)
        self.playLottie()
    }
    
    
    func playLottie() {
        
        bigAnimationView.animation = LottieAnimation.named(AnimationJson.Star)
        bigAnimationView.loopMode = .loop
        bigAnimationView.contentMode = .scaleAspectFill
        bigAnimationView.play { _ in
        }
        
        smallAnimationView.animation = LottieAnimation.named(AnimationJson.Win)
        smallAnimationView.loopMode = .loop
        smallAnimationView.contentMode = .scaleAspectFit
        smallAnimationView.play { _ in
        }
        
        
    }
    
}
