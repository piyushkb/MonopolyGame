 
import UIKit
import Lottie
class ChanceVC: UIViewController {

    @IBOutlet weak var chanceImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var titleText = ""
    var descriptionText = ""
    var imageName = ""
    var completionHandler:(() -> Void)?
   
    var chanceIsGood = true
    let closeIn = 7.0
    @IBOutlet weak var chanceLabel: UILabel!
    
    @IBOutlet weak var lottieAnimatoinView: LottieAnimationView!
    
    @IBAction func onClose(_ sender: Any) {
        
        if let completionHandler =  completionHandler{
            completionHandler()
        }
        self.completionHandler!()
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        
        self.titleLabel.text = titleText
        self.chanceLabel.text = self.descriptionText
        self.chanceImage.image = UIImage(named: imageName)
        self.view.viewWithTag(12)!.dropShadow()
        self.view.viewWithTag(12)!.cornerRadius = 30
        
        DispatchQueue.main.asyncAfter(deadline: .now() + closeIn) {
            self.onClose(UIButton())
        }
        
        if(chanceIsGood) {
            self.playAnimation(json: AnimationJson.Star)
        }else {
            self.playAnimation(json: AnimationJson.SAD)
            playSound(soundName:AnimationJson.SAD)
        }
        
    }
    
    
    func playAnimation(json:String) {
        lottieAnimatoinView.animation = LottieAnimation.named(json)
        lottieAnimatoinView.loopMode = .playOnce
        lottieAnimatoinView.contentMode = .scaleAspectFill
        lottieAnimatoinView.play()
    }
    

}
