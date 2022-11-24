 

protocol CellDelegate: AnyObject {
    func buttonPressed(section: Int, row:Int)
}

import UIKit

class AssetCell: UITableViewCell {

    weak var delegate : CellDelegate?
    var section = 0
    var row = 0
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var sellAmount: UILabel!
    @IBOutlet weak var cardName: UILabel!
   
    func setCell(section:Int,row:Int) {
        self.row = row
        self.section = section
    }
    
    @IBAction func sellButtonTapped(_ sender: Any) {
        if delegate != nil {
            self.delegate?.buttonPressed(section: section, row: row)
        }
    }
    
}
