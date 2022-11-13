 

import UIKit
import SpriteKit
import GameplayKit
 
class GameViewController: UIViewController {
    
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
        self.tableView.registerCells([PlayerCell.self])
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view?.isMultipleTouchEnabled = false
        self.setupGame()
        
        if let view = self.gameBoardScene   {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "BoardScene") as? BoardScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .fill
                self.boardScene = scene
                scene.vc = self
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
        
        let images = Const.dices
        
        players.append(Player(isActive: true, playerImage: images[0], playerId: 1.description, totalMoney: 1500, playerName: "Ashok", playerPosition: Const.INITIAL_POSITION_PLAYER))
        
        players.append(Player(isActive: false, playerImage: images[1], playerId: 2.description, totalMoney: 1500, playerName: "Mohan", playerPosition: Const.INITIAL_POSITION_PLAYER))
        
        
        players.append(Player(isActive: false, playerImage: images[2], playerId: 3.description, totalMoney: 1500, playerName: "Rajeev", playerPosition: Const.INITIAL_POSITION_PLAYER))
        
        players.append(Player(isActive: false, playerImage: images[3], playerId: 4.description, totalMoney: 1500, playerName: "Suresh", playerPosition: Const.INITIAL_POSITION_PLAYER))
        
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
        
//        guard let dice1 = player.dice1, let dice2 = player.dice2 else { return }
//        updateUI()
        
    }
  
}

 

 
