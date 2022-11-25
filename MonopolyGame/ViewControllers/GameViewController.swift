 

import UIKit
import SpriteKit
import GameplayKit
import Lottie

var  gameViewController : GameViewController!

class GameViewController: UIViewController {
   
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    @IBOutlet weak var bigAnimationView: LottieAnimationView!
    @IBOutlet weak var bottomSpaceDiceView: NSLayoutConstraint!
    @IBOutlet weak var DiceAnimationView: UIView!
    public var dice1ImageView: UIImageView!
    public var dice2ImageView: UIImageView!
    public var dynamicAnimator: UIDynamicAnimator!
    public var collisionBehavior: UICollisionBehavior!
    public var bouncingBehavior: UIDynamicItemBehavior!
    public var gravityBehavior: UIGravityBehavior!
  
    
    @IBOutlet weak var gameBoardScene: SKView!
    @IBOutlet weak var tableView: UITableView!
    var boardScene : SKScene!
    var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        gameViewController = self
        self.hideBigLottie()
        self.hideLottie()
        self.tableView.registerCells([PlayerCell.self])
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view?.isMultipleTouchEnabled = false
        if(isiPad()) {
            self.bottomSpaceDiceView.constant = 100
        }else {
            self.bottomSpaceDiceView.constant = 50
        }
        self.setupGame()
       
        if let view = self.gameBoardScene   {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "BoardScene") as? BoardScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .fill
                self.boardScene = scene
                vc = self
                scene.players = self.players
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.isMultipleTouchEnabled = false
        }
        
        
        self.tableView.backgroundColor = UIColor(white: 1, alpha: 0.5)
       
    }
    
    override func viewDidLayoutSubviews() {
        if(isiPad()) {
            self.lottieAnimationView.frame.size = CGSize(width: 500,height: 500)
            lottieAnimationView.center = self.gameBoardScene.center
        }else {
            self.lottieAnimationView.frame.size = CGSize(width: 250,height: 250)
            lottieAnimationView.center = self.gameBoardScene.center
        }
    }

    func showLottieAnimation(mode:UIView.ContentMode = UIView.ContentMode.scaleAspectFit, json:String,completion: @escaping ()->()) {
        lottieAnimationView.animation = LottieAnimation.named(json)
        lottieAnimationView.loopMode = .playOnce
        lottieAnimationView.contentMode = mode
        self.showLottie()
        lottieAnimationView.play { _ in
            self.hideLottie()
            completion() // sendCall back when animation complete
        }
    }
    
    func showBigLottieAnimation(mode:UIView.ContentMode = UIView.ContentMode.scaleToFill, json:String,completion: @escaping ()->()) {
        bigAnimationView.animation = LottieAnimation.named(json)
        bigAnimationView.loopMode = .playOnce
        bigAnimationView.contentMode = mode
        self.showBigLottie()
        bigAnimationView.play { _ in
            self.hideBigLottie()
            completion() // sendCall back when animation complete
        }
    }

    func hideBigLottie(){
        bigAnimationView.isHidden = true
    }
    func showBigLottie(){
        bigAnimationView.isHidden = false
    }
    
    
    func hideLottie(){
        lottieAnimationView.isHidden = true
    }
    func showLottie(){
        lottieAnimationView.isHidden = false
    }
   
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}


extension GameViewController {
    
    func setupGame() {
        
        configDiceImageView(&dice1ImageView)
        configDiceImageView(&dice2ImageView)
        configAnimation()
     
        
        
         SoundAndHapticController.cacheSounds(soundNames: Const.DiceRollSoundFileNames, fileType: Const.SoundFileType)
        
        
            //self.playSound()
    }
    
    func playSound() {
        
        if(Const.DefaultIsMusicEnabled) {
            SoundAndHapticController.playNext()
        }
    }
}


extension GameViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell" ) as! PlayerCell
        cell.setCell(player: players[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AssetsVC") as! AssetsVC
        vc.player = self.players[indexPath.row]
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
}


extension GameViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//      let node = self.getTappedNode(touches, scene: boardScene, name: "rollButton")
//
//        if(node.2) {
//            print("Roll Button Tapped")
//            roll()
//            //node.0!.texture = SKTexture(imageNamed: "hat")
//        }
    
  }
}

 
extension GameViewController{
    
    func getActivePlayer() -> Player {
        let player = self.players.filter{$0.isActive}.first
        return player!
    }
    
    
}

 

 


extension GameViewController {
   
   func roll() {
      
      let player = getActivePlayer()
      
      player.rollDice()
      
      if let dice1 = player.dice1 {
          DiceAnimationView.addSubview(dice1ImageView)
         animateDiceImageView(dice1ImageView, diceFace: dice1)
      }
      
      if let dice2 = player.dice2 {
          DiceAnimationView.addSubview(dice2ImageView)
          animateDiceImageView(dice2ImageView, diceFace: dice2)
      }
      
  }
}


extension GameViewController {
    
    @IBAction func onExit(_ sender: Any) {
        
//        showConfirmationAlertGlobal(message: "Are you sure want to exit?") { value in
//            
//            if(value){
//                self.players.removeAll()
//                landingVc.players.removeAll()
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    self.dismiss(animated: true)
//                    SoundAndHapticController.stopMusic()
//                }
//               
//            }
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.players.removeAll()
//        landingVc.players.removeAll()
    }
}


extension GameViewController {
    
    func showChanceOrChestCard(title:String,description:String,image:String, chanceIsGood:Bool,completion:@escaping () -> Void){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChanceVC") as! ChanceVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        vc.titleText = title
        vc.descriptionText = description
        vc.imageName = image
        vc.chanceIsGood = chanceIsGood
        vc.completionHandler =  {
            completion()
        }
        self.present(vc, animated: true)
    }
    
    func showUtilityCard(title:String,description:String,lottieJsonName:String,completion:@escaping () -> Void){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UtilityVC") as! UtilityVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        vc.titleText = title
        vc.descriptionText = description
        vc.lottieAnimationName = lottieJsonName
        vc.completionHandler =  {
            completion()
        }
        self.present(vc, animated: true)
    }
    
    
    func showRailRoadCard(player:Player,amount:Int,title:String,description:String,alreadyOwned:Bool, completion:@escaping () -> Void){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RailRoadVC") as! RailRoadVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        vc.titleText = title
        vc.descriptionText = description
        vc.alreadyOwned = alreadyOwned
        vc.player = player
        vc.buyAmount = amount
        vc.completionHandler =  {
            completion()
        }
        self.present(vc, animated: true)
    }
    
     
    
    func opneCardVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PropertyCardVc") as! PropertyCardVc
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: true)
    }

}


 
func showWinnerScreen(){
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WinnerVC") as! WinnerVC
   // vc.modalPresentationStyle = .fullScreen
    vc.player = gameViewController.players.first
    vc.modalPresentationStyle = .overFullScreen
    UIApplication.topViewController()!.present(vc, animated: true)
    
}
