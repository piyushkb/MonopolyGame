 
import UIKit
import Lottie

class AssetsVC : UIViewController, CellDelegate{
    
    @IBOutlet weak var moneyAvailable: UILabel!
    var player:Player!
    var spndingAmount = 0
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    @IBOutlet weak var successLottieView: LottieAnimationView!
    var completionHandler:(() -> Void)?
    var mustSpend = false
    override func viewDidLoad() {
       self.tableView.registerCells([AssetCell.self])
       self.tableView.delegate = self
       self.tableView.dataSource = self
       self.userLabel.text = "\(player.playerName)'s \n All Assets List"
       self.playLottie()
       self.tableView.reloadData()
       self.successLottieView.isHidden = true
        self.setMoney()
   }
    
    func setMoney() {
        self.moneyAvailable.text = "Available Balance - $" + player.getTotalMoneyString()
    }
   
    func showSuccessLottieAnimation() {
        successLottieView.animation = LottieAnimation.named(AnimationJson.Success)
        successLottieView.loopMode = .repeat(2)
        successLottieView.contentMode = .scaleAspectFit
        self.successLottieView.isHidden = false
        successLottieView.play { _ in
            self.successLottieView.isHidden = true
        }
    }
    
   
    func playLottie() {
        
        lottieAnimationView.animation = LottieAnimation.named(AnimationJson.Assets)
        lottieAnimationView.loopMode = .playOnce
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.play { _ in
        }
        
    }
   
}

extension AssetsVC : UITableViewDelegate,UITableViewDataSource {
    
    
    @IBAction func onClose(_ sender: Any) {
        
        if(mustSpend) {
            
            if(self.spndingAmount > self.player.totalMoney) {
                showAlertAnyWhere(message: "You Need to Sell more Assets for pay the required amount $\(spndingAmount).")
            }else {
                self.dismiss(animated: true)
                if let completionHandler = completionHandler{
                    completionHandler()
                }
            }
            
            
        }else {
            self.dismiss(animated: true)
        }
      
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         
        return player.assets.getAllAssetsTypes().count
    }
     
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return player.assets.getAllAssetsTypes()[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let assetName = player.assets.getAllAssetsTypes()[section]
        
        if(assetName == Assets.UtilityText) {
            return player.assets.utilities.count
        }else if(assetName == Assets.RailRoadText) {
            return player.assets.railRoads.count
        }else if(assetName == Assets.LandsText) {
            return player.assets.lands.count
        }
//        else if(assetName == Assets.HouseText) {
//            return player.assets.houses.count
//        }
//
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssetCell" ) as! AssetCell
        
        let assetName = player.assets.getAllAssetsTypes()[indexPath.section]
        
        if(assetName == Assets.UtilityText) {
            let asset = player.assets.utilities[indexPath.row]
            cell.cardName.text = asset.rawValue
            cell.sellAmount.text = "\(Const.StringSell) $ " + UtilityCard.WATER_WORKS.sellValue.description
            
        }else if(assetName == Assets.RailRoadText) {
            let asset = player.assets.railRoads[indexPath.row]
            cell.cardName.text = asset.rawValue
            cell.sellAmount.text = "\(Const.StringSell) $ " + RailRoadCard.sellValue.description
        }else if(assetName == Assets.LandsText) {
            let asset = player.assets.lands[indexPath.row]
            cell.cardName.text = asset.name
            cell.sellAmount.text = "\(Const.StringSell) $ "  + asset.getSellValue().description
        }
//        else if(assetName == Assets.HouseText) {
//            let asset = player.assets.houses[indexPath.row]
//            cell.cardName.text = ""
//            cell.sellAmount.text = ""
//        }
        cell.delegate = self
        cell.setCell(section: indexPath.section, row: indexPath.row)
        cell.sellButton.tag = indexPath.row
        cell.backgroundColor = .clear
        
        return cell
    }
    
}


extension AssetsVC {
    
    func buttonPressed(section: Int, row: Int) {
        
        showConfirmationAlertGlobal(message: "Do you want to sell this asset?") { value in
            if value {
                let assetName = self.player.assets.getAllAssetsTypes()[section]
                self.player.assets.removeAsset(player: self.player, assetName: assetName, index: row)
                self.showSuccessLottieAnimation()
                playSound(soundName: AnimationJson.Success)
                self.setMoney()
                self.tableView.reloadData()
            }
        }
    }
}
