
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
    
    
}

struct UtilityCard{
    struct WATER_WORKS{
        static let title = "WATER WORKS"
        static let desc = "If one Utility is owned, Rent is 4 times amount shown on dice. If both Utilities are owned, Rent is 10 times amount shown on dice."
        static let amount = 150
    }
    
    struct ELECTRICITY{
        static let title = "ELECTRIC COMPANY"
        static let desc = "If one Utility is owned, Rent is 4 times amount shown on dice. If both Utilities are owned, Rent is 10 times amount shown on dice."
        static let amount = 150
    }
    
    static func getSingleCardRent(rollValue:Int) -> Int{
        return rollValue * 4
    }
    static func getBothCardRent(rollValue:Int) -> Int{
        return rollValue * 10
    }
}

struct ChancesCard{
    struct SPEEDING_FINE{
        static let title = "SPEEDING FINE"
        static let desc = "PAY $15"
        static let amount = 15
    }
    
    struct BANK_PAYS_DIVENDED{
        static let title = "BANK PAYS YOU"
        static let desc = "DIVIDEND OF $50"
        static let amount = 50
    }
    
    struct GO_TO_JAIL{
        static let title = "GO TO JAIL"
        static let desc = "GO DIRECTLY TO JAIL, DO NOT COLLECT $200"
        static let amount = 0
    }
}

struct CommunityChestCard{
    
    struct DOCTORS_FEE{
        static let title = "DOCTOR'S FEE"
        static let desc = "PAY $50"
        static let amount = 50
    }
    
    struct SCHOOL_FEE{
        static let title = "SCHOOL FEES"
        static let desc = "PAY $50"
        static let amount = 50
    }
    
    struct INCOME_TAX_REFUND{
        static let title = "INCOME TEX REFUND"
        static let desc = "COLLECT $20"
        static let amount = 20
    }
    
    struct HOLIDAY_FUND_MATURES{
        static let title = "HOLIDAY FUND MATURES"
        static let desc = "RECEIVE $100"
        static let amount = 100
    }
    
}

struct TaxCharges{
    static let INCOME_TAX = 200
    static let LUXURY_TAX = 100
}

struct RailRoadCard{
    static let amount = 200
    static func getRent(ownedStationsCount:Int) -> Int{
        ownedStationsCount * 25
    }
}

 

struct AnimationJson {
    
    static let JAIL =  "jail"
    static let Chance =  "chance"
    static let Chest =  "chest"
    static let Tax =  "tax"
    static let Rail =  "rail"
    static let Parking =  "parking"
    static let Light =  "light"
    static let Water =  "water"
    static let Star =  "star"
    
}

//
//let GO = "A0"
//let MEDITER_RANEAN = "A1"
//let COMMUNITY_CHEST = "A2"
//let BALTIC_AVENUE = "A3"
//let INCOM_TAX = "A4"
//let READING_RAILROAD = "A5"
//let ORIENTAL_AVENUE = "A6"
//let CHANCE = "A7"
//let VERMONT_AVENUE = "A8"
//let CONNECTICUT_AVENUE = "A9"
//let JAIL_VISITING = "A10"
//
//
//let ST_CHARLES = "A11"
//let ELECTRICITY = "A12"
//let STATUS_AVENUE = "A13"
//let VIRGINIA_AVENUE = "A14"
//let PENNSYLVANIA_RAILROAD = "A15"
//let ST_JAMES_PLACE = "A16"
//let COMMUNITY_CHEST2 = "A17"
//let TENNESSEE_AVENUE = "A18"
//let NEW_YOURK_AVENUE = "A19"
//let FREE_PARKING = "A20"
//
//
//let KENTUCKY_AVENUE = "A21"
//let CHANCE2 = "A22"
//let INDIANA_AVENUE = "A23"
//let ILLINOIS_AVENUE = "A24"
//let B_O_RAILROAD = "A25"
//let ATLANTIC_AVENUE = "A26"
//let VENTINOR_AVENUE = "A27"
//let WATER_WORKS = "A28"
//let MARVIN_GARDENS = "A29"
//let GO_TO_JAIL = "A30"
//
//let PACIFIC_AVENUE = "A31"
//let NORTH_CAROLINA_AVENUE = "A32"
//let COMMUNITY_CHEST3 = "A33"
//let PENNSYLVANIA_AVENUE = "A34"
//let SHORT_LINE = "A35"
//let CHANCE3 = "A36"
//let PARK_PLACE = "A37"
//let LUXARY_TAX = "A38"
//let BOARD_WALK = "A39"
//

func getSpaceFromPosition(position:String) -> PlayerSpace {
    
    let values: [PlayerSpace] = PlayerSpace.allCases.map { $0 }
    
    
    for item in values {
        if(item.rawValue == position ) {
            return item
        }
    }
    
    return .GO
 
}

enum PlayerSpace: String, CaseIterable { 
    
    case  GO = "A0"

    case  MEDITER_RANEAN = "A1"

    case  COMMUNITY_CHEST = "A2"

    case  BALTIC_AVENUE = "A3"

    case  INCOME_TAX = "A4"

    case  READING_RAILROAD = "A5"

    case  ORIENTAL_AVENUE = "A6"

    case  CHANCE = "A7"

    case  VERMONT_AVENUE = "A8"

    case  CONNECTICUT_AVENUE = "A9"

    case  JAIL_VISITING = "A10"

    case  ST_CHARLES = "A11"

    case  ELECTRICITY = "A12"

    case  STATUS_AVENUE = "A13"

    case  VIRGINIA_AVENUE = "A14"

    case  PENNSYLVANIA_RAILROAD = "A15"

    case  ST_JAMES_PLACE = "A16"

    case  COMMUNITY_CHEST2 = "A17"

    case  TENNESSEE_AVENUE = "A18"

    case  NEW_YOURK_AVENUE = "A19"

    case  FREE_PARKING = "A20"

    case  KENTUCKY_AVENUE = "A21"

    case  CHANCE2 = "A22"

    case  INDIANA_AVENUE = "A23"

    case  ILLINOIS_AVENUE = "A24"

    case  B_O_RAILROAD = "A25"

    case  ATLANTIC_AVENUE = "A26"

    case  VENTINOR_AVENUE = "A27"

    case  WATER_WORKS = "A28"

    case  MARVIN_GARDENS = "A29"

    case  GO_TO_JAIL = "A30"

    case  PACIFIC_AVENUE = "A31"

    case  NORTH_CAROLINA_AVENUE = "A32"

    case  COMMUNITY_CHEST3 = "A33"

    case  PENNSYLVANIA_AVENUE = "A34"

    case  SHORT_LINE = "A35"

    case  CHANCE3 = "A36"

    case  PARK_PLACE = "A37"

    case  LUXARY_TAX = "A38"

    case  BOARD_WALK = "A39"
     
}

func isiPad()->Bool{
    
    if UIDevice.current.userInterfaceIdiom == .pad {
         return true
     } else {
         return false
    }
}




//extension String {
//
//    func getLandedSpaceName()->String{
//
//        let space = self
//
//        switch space {
//
//        case Const.GO:
//            return Const.GO
//
//        case Const.MEDITER_RANEAN:
//            return Const.MEDITER_RANEAN
//
//        case Const.COMMUNITY_CHEST:
//            return Const.COMMUNITY_CHEST
//
//        case Const.BALTIC_AVENUE:
//            return Const.BALTIC_AVENUE
//
//        case Const.INCOM_TAX:
//            return Const.INCOM_TAX
//
//        case Const.READING_RAILROAD:
//            return Const.READING_RAILROAD
//
//        case Const.ORIENTAL_AVENUE:
//            return Const.ORIENTAL_AVENUE
//
//        case Const.CHANCE:
//            return Const.CHANCE
//
//        case Const.VERMONT_AVENUE:
//            return Const.VERMONT_AVENUE
//
//        case Const.CONNECTICUT_AVENUE:
//            return Const.CONNECTICUT_AVENUE
//
//        case Const.JAIL_VISITING:
//            return Const.JAIL_VISITING
//
//        default:
//            return ("No Space")
//        }
//
//    }
//
//}
 
