 
import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var playerMoney: UILabel!
    
    var player : Player!
    
    func setCell(player:Player){
        self.player = player
        self.playerName.text = player.getPlayerName()
        self.playerImage.image = player.getImage()
        self.playerMoney.text = player.getTotalMoneyString()
    }
    
}
