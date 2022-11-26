 
import UIKit

var landingVc : LandingVc!

class LandingVc: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var moneyStepper: UIStepper!
    @IBOutlet weak var playerSegment: UISegmentedControl!
    let images =  Const.dices
    
      var  players : [Player] = [] {
        didSet {
            self.tableView.reloadData()
            self.tableView.scrollToBottom()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        landingVc = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.registerCells([PlayerSetupCell.self])
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        players.append(Player(isActive: true, playerImage: images[0], playerId: 1.description, totalMoney: 0, playerName: "", playerPosition: .GO))
        
        players.append(Player(isActive: false, playerImage: images[1], playerId: 2.description, totalMoney: 0, playerName: "", playerPosition: .GO))
    }
    
    
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        self.addPlayer()
    }
    
    
    func removePlayers(){

        let segmentIndex =  playerSegment.selectedSegmentIndex + 2
      
        var temp = self.players
        
        for _ in 0..<players.count {
           
            if(segmentIndex >= temp.count) {
                
            }else {
                temp.removeLast()
            }
        }
        
        self.players = temp
        
    }
    
    
    
    func addPlayer(){
        
        
        let segmentIndex =  playerSegment.selectedSegmentIndex
      
        
        if(segmentIndex == 1) {
            players.append(Player(isActive: false, playerImage: images[2], playerId: 3.description, totalMoney: 0, playerName: "", playerPosition: .GO))
        }

        if(segmentIndex == 2) {
            
            if(players.count == 2) {
                players.append(Player(isActive: false, playerImage: images[2], playerId: 3.description, totalMoney: 0, playerName: "", playerPosition: .GO))
                
                players.append(Player(isActive: false, playerImage: images[3], playerId: 4.description, totalMoney: 0, playerName: "", playerPosition: .GO))
                
            }else{
                players.append(Player(isActive: false, playerImage: images[3], playerId: 4.description, totalMoney: 0, playerName: "", playerPosition: .GO))
            }
          
        }
        
        self.removePlayers()
       
    }
    
    @IBAction func onStepper(_ sender: Any) {
        self.money.text = moneyStepper.value.description + "$"
    }
    

}


extension LandingVc : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerSetupCell" ) as! PlayerSetupCell
        cell.setCell(player: players[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}




extension LandingVc {
    
  
    @IBAction func onPlay(_ sender: Any) {
    
        self.view.endEditing(true)
        
        let t = players.filter({$0.getPlayerName() == ""})
            
        if(t.count > 0) {
            showAlertAnyWhere(message: "Please Enter All Players Name")
        }else {
            
            
            if(soundSwitch.isOn) {
                Const.DefaultIsMusicEnabled = true
            }else {
                Const.DefaultIsMusicEnabled = false
            }
            
            
             // uncomment
            for player in players {
                player.setTotalMoney(totalMoney: Int(moneyStepper.value))
            }
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            vc.modalPresentationStyle = .fullScreen
            vc.players = players
        
            self.present(vc, animated: true)
        }
    }
    
    
}
