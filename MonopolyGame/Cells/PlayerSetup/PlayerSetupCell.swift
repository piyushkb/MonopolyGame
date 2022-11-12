 

import UIKit

class PlayerSetupCell: UITableViewCell {
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var playerImage: UIImageView!
    
    var player : Player!
    
    func setCell(player:Player){
        self.player = player
        self.playerName.text = player.getPlayerName()
        self.playerImage.image = player.getImage()
        self.playerName.delegate = self
    }
    
}

extension PlayerSetupCell : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let cs = NSCharacterSet(charactersIn:Const.ACCEPTABLE_CHARACTERS).inverted
        let filtered = string.components(separatedBy: cs).joined(separator: "")
        return (string == filtered)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
         
        self.player.setName(name: textField.text!)
        
    }
}
