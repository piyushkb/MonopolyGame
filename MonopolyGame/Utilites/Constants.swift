
import UIKit

// MARK: - Constants

enum GameType: String {
    case PigGame2Dice
}

enum ColorMode: String {
    case Light
    case Dark
    case System
}

enum BackgroundImage: String {
    case piggies
    case blackboard
    case none
}

struct Const {
    // Assets
    static let DiceFaces = [#imageLiteral(resourceName: "dice-1"), #imageLiteral(resourceName: "dice-2"), #imageLiteral(resourceName: "dice-3"), #imageLiteral(resourceName: "dice-4"), #imageLiteral(resourceName: "dice-5"), #imageLiteral(resourceName: "dice-6")]
    static var DiceSize = 100
    
    static let DiceRollSoundFileNames = ["dice_collision1", "dice_collision2", "dice_collision3", "dice_collision4"]
    static let SoundFileType = "wav"
    static let MusicFiles: [String] = ["MonopolyMusic2" , "MonopolyMusic" , "MonopolyMusic3"]
    static let MusicFileType = "mp3"
    static let dices = ["redDisk" , "blueDisk","greenDisk", "yellowDisk"]

    // Game
    
    static let font = "Lato-Regular"
    static let cornerRadius = CGFloat(8)
    
    static let delay = 2.0
    
    static let DefaultColorMode: ColorMode = .System
    static let DefaultBackgroundImage: BackgroundImage = .blackboard
    static var DefaultIsSoundEnabled = true
    static var DefaultIsMusicEnabled = true
    static let DefaultIsVibrationEnabled = false
    static let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    static let INITIAL_POSITION_PLAYER = "A0"

}

func isiPad()->Bool{
    
    if UIDevice.current.userInterfaceIdiom == .pad {
         return true
     } else {
         return false
    }
}
