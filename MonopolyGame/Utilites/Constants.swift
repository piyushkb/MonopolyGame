
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
    static let StringSell = "Sell Value" // Mortgage
    static let GO_PASS_AMOUNT = 200
    // Assets
    static let DiceFaces = [#imageLiteral(resourceName: "dice-1"), #imageLiteral(resourceName: "dice-2"), #imageLiteral(resourceName: "dice-3"), #imageLiteral(resourceName: "dice-4"), #imageLiteral(resourceName: "dice-5"), #imageLiteral(resourceName: "dice-6")]
    static var DiceSize = 100
    
    static let DiceRollSoundFileNames = ["dice_collision1", "dice_collision2", "dice_collision3", "dice_collision4"]
    static let SoundFileType = "wav"
    static let MusicFiles: [String] = ["MonopolyMusic2" , "MonopolyMusic" , "MonopolyMusic3"]
    static let MusicFileType = "mp3"
    static let dices = ["redDisk" , "blueDisk","greenDisk", "yellowDisk"]
    static let GO_PASS_SOUND = "goPass"


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

var playMoveSound = true

struct ConstImages {
    static let PAY_FEE = "pay_fee"
    static let MAN = "chance_man"
    static let GO_TO_JAIL = "Go-To-JAIl"
}

struct UtilityCard{
    struct WATER_WORKS{
        static let title = "WATER WORKS"
        static let desc = "If one Utility is owned, Rent is 4 times amount shown on dice. If both Utilities are owned, Rent is 10 times amount shown on dice."
        static let amount = 150
        static let sellValue = 75
    }
    
    struct ELECTRICITY{
        static let title = "ELECTRIC COMPANY"
        static let desc = "If one Utility is owned, Rent is 4 times amount shown on dice. If both Utilities are owned, Rent is 10 times amount shown on dice."
        static let amount = 150
        static let sellValue = 75
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
        static let desc = "GO DIRECTLY TO JAIL"
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
    
    static let des = """
    Rent  $25.
    
    If 2 R.R.'s are owned $50.
    
    If 3 R.R.'s are owned $100.
    
    If 4 R.R.'s are owned $200.
    
    
    \(Const.StringSell) Value $100.
    """
    static let sellValue = 100
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
    static let SAD =  "sad"
    static let Credit =  "credit" // sound only no lotiiee
    static let Win =  "winner"
    static let Assets =  "assets"
    static let Success = "success"
    static let Property = "property"
    
    
}

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


 
enum BuyingType {
    case Land
    case House
    case Hotel
}
 
func getPropertyCard(space:PlayerSpace) -> PropertyCard {
    
       switch space {
            
        case .MEDITER_RANEAN:
           return PropertyCard(space: space, name: "Mediterranean Avenue", pricetext: "$60", color: "#8B4513", price: 60, groupNumber: 3, baserent: 2, rent1: 10, rent2: 30, rent3: 90, rent4: 160, rent5: 250)
            
        case .BALTIC_AVENUE:
           return PropertyCard(space: space, name: "Baltic Avenue", pricetext: "$60", color: "#8B4513", price: 60, groupNumber: 3, baserent: 4, rent1: 20, rent2: 60, rent3: 180, rent4: 320, rent5: 450)
        case .ORIENTAL_AVENUE:
           return PropertyCard(space: space, name: "Oriental Avenue", pricetext: "$100", color: "#87CEEB", price: 100, groupNumber: 4, baserent: 6, rent1: 30, rent2: 90, rent3: 270, rent4: 400, rent5: 550)
        case .VERMONT_AVENUE:
           return PropertyCard(space: space, name: "Vermont Avenue", pricetext: "$100", color: "#87CEEB", price: 100, groupNumber: 4, baserent: 6, rent1: 30, rent2: 90, rent3: 270, rent4: 400, rent5: 550)
        case .CONNECTICUT_AVENUE:
           return PropertyCard(space: space, name: "Connecticut Avenue", pricetext: "$120", color: "#87CEEB", price: 120, groupNumber: 4, baserent: 8, rent1: 40, rent2: 100, rent3: 300, rent4: 450, rent5: 600)
        case .ST_CHARLES:
           return PropertyCard(space: space, name: "St. Charles Place", pricetext: "$140", color: "#FF0080", price: 140, groupNumber: 5, baserent: 10, rent1: 50, rent2: 150, rent3: 450, rent4: 625, rent5: 750)
        case .STATUS_AVENUE:
           return PropertyCard(space: space, name: "States Avenue", pricetext: "$140", color: "#FF0080", price: 140, groupNumber: 5, baserent: 10, rent1: 50, rent2: 150, rent3: 450, rent4: 625, rent5: 750)
        case .VIRGINIA_AVENUE:
           return PropertyCard(space: space, name: "Virginia Avenue", pricetext: "$160", color: "#FF0080", price: 160, groupNumber: 5, baserent: 12, rent1: 60, rent2: 180, rent3: 500, rent4: 700, rent5: 900)
        case .ST_JAMES_PLACE:
           return PropertyCard(space: space, name: "St. James Place", pricetext: "$180", color: "#FFA500", price: 180, groupNumber: 6, baserent: 14, rent1: 70, rent2: 200, rent3: 550, rent4: 750, rent5: 950)
        case .TENNESSEE_AVENUE:
           return PropertyCard(space: space, name: "Tennessee Avenue", pricetext: "$180", color: "#FFA500", price: 180, groupNumber: 6, baserent: 14, rent1: 70, rent2: 200, rent3: 550, rent4: 750, rent5: 950)
        case .NEW_YOURK_AVENUE:
           return PropertyCard(space: space, name: "New York Avenue", pricetext: "$200", color: "#FFA500", price: 200, groupNumber: 6, baserent: 16, rent1: 80, rent2: 220, rent3: 600, rent4: 800, rent5: 1000)
        case .KENTUCKY_AVENUE:
           return PropertyCard(space: space, name: "Kentucky Avenue", pricetext: "$220", color: "#FF0000", price: 220, groupNumber: 7, baserent: 18, rent1: 90, rent2: 250, rent3: 700, rent4: 875, rent5: 1050)
        case .INDIANA_AVENUE:
           return PropertyCard(space: space, name: "Indiana Avenue", pricetext: "$220", color: "#FF0000", price: 220, groupNumber: 7, baserent: 18, rent1: 90, rent2: 250, rent3: 700, rent4: 875, rent5: 1050)
        case .ILLINOIS_AVENUE:
           return PropertyCard(space: space, name: "Illinois Avenue", pricetext: "$240", color: "#FF0000", price: 240, groupNumber: 7, baserent: 20, rent1: 100, rent2: 300, rent3: 750, rent4: 925, rent5: 1100)
        case .ATLANTIC_AVENUE:
           return PropertyCard(space: space, name: "Atlantic Avenue", pricetext: "$260", color: "#FFFF00", price: 260, groupNumber: 8, baserent: 22, rent1: 110, rent2: 330, rent3: 800, rent4: 975, rent5: 1150)
        case .VENTINOR_AVENUE:
           return PropertyCard(space: space, name: "Ventnor Avenue", pricetext: "$260", color: "#FFFF00", price: 260, groupNumber: 8, baserent: 22, rent1: 110, rent2: 330, rent3: 800, rent4: 975, rent5: 1150)
        case .MARVIN_GARDENS:
           return PropertyCard(space: space, name: "Marvin Gardens", pricetext: "$280", color: "#FFFF00", price: 280, groupNumber: 8, baserent: 24, rent1: 120, rent2: 360, rent3: 850, rent4: 1025, rent5: 1200)
        case .PACIFIC_AVENUE:
           return PropertyCard(space: space, name: "Pacific Avenue", pricetext: "$300", color: "#008000", price: 300, groupNumber: 9, baserent: 26, rent1: 130, rent2: 390, rent3: 900, rent4: 1100, rent5: 1275)
        case .NORTH_CAROLINA_AVENUE:
           return PropertyCard(space: space, name: "North Carolina Avenue", pricetext: "$300", color: "#008000", price: 300, groupNumber: 9, baserent: 26, rent1: 130, rent2: 390, rent3: 900, rent4: 1100, rent5: 1275)
        case .PENNSYLVANIA_AVENUE:
           return PropertyCard(space: space, name: "Pennsylvania Avenue", pricetext: "$320", color: "#008000", price: 320, groupNumber: 9, baserent: 28, rent1: 150, rent2: 450, rent3: 1000, rent4: 1200, rent5: 1400)
         case .PARK_PLACE:
           return PropertyCard(space: space, name: "Park Place", pricetext: "$350", color: "#0000FF", price: 350, groupNumber: 10, baserent: 35, rent1: 175, rent2: 500, rent3: 1100, rent4: 1300, rent5: 1500)
        case .BOARD_WALK:
           return PropertyCard(space: space, name: "Boardwalk", pricetext: "$400", color: "#0000FF", price: 400, groupNumber: 10, baserent: 50, rent1: 200, rent2: 600, rent3: 1400, rent4: 1700, rent5: 2000)
        default :
           return PropertyCard(space: space, name: "", pricetext: "$0", color: "#0000FF", price: 0, groupNumber: 0, baserent: 0, rent1: 0, rent2: 0, rent3: 0, rent4: 0, rent5: 0)
        }
         
    }
    

 
struct PropertyCard {
    
    var name:String
    var pricetext:String
    var color:String
    var owner = 0
    var mortgage = false
    var house = 0
    var hotel = 0
    var groupNumber = 0
    var price :Int
    var baserent:Int
    var rent1:Int
    var rent2:Int
    var rent3:Int
    var rent4:Int
    var rent5:Int
    var landcount:Int
    var houseprice:Int
    var space : PlayerSpace
    
    init(space:PlayerSpace,name:String, pricetext:String, color:String, price:Int, groupNumber:Int, baserent:Int, rent1:Int, rent2:Int, rent3:Int, rent4:Int, rent5:Int) {
        self.name = name
        self.pricetext = pricetext
        self.color = color
        self.mortgage = false
        self.house = 0
        self.hotel = 0
        self.groupNumber = groupNumber
        self.price = price
        self.baserent = baserent
        self.rent1 =  rent1
        self.rent2 =  rent2
        self.rent3 =  rent3
        self.rent4 =  rent4
        self.rent5 =  rent5
        self.landcount = 0
        self.space = space
        
        if (groupNumber == 3 || groupNumber == 4) {
            self.houseprice = 50
        } else if (groupNumber == 5 || groupNumber == 6) {
            self.houseprice = 100
        } else if (groupNumber == 7 || groupNumber == 8) {
            self.houseprice = 150
        } else if (groupNumber == 9 || groupNumber == 10) {
            self.houseprice = 200
        } else {
            self.houseprice = 0
        }
    }
    
    func getPriceInt()->Int{
        return pricetext.replacingOccurrences(of: "$", with: "", options: NSString.CompareOptions.literal, range:nil).toInt()
    }
    
    func getSellValue()->Int{
        return (self.getPriceInt() / 2)
    }
    
    func getColor()->UIColor{
        return self.color.getColor()
    }
    
    
    func getDescription()->String{
        
        let desc = """
        Cost  $\(self.price).
        
        Rent  $\(self.baserent).
        
        If a player owns ALL the Lots of any Color Rent Will Double.
        
        \(Const.StringSell)  $\(getSellValue()).
        """
        return desc
    }
    
//
//        func getSaleValue(space:PlayerSpace,player:Player,buying:BuyingType,amount:Int)->Int{
//            return calculatePropertyValue(player:player,space: space, amount: amount) // amount is not require here , we are passsing the amount for now only Later we need to calucalte the amount self
//        }
//
//        func calculatePropertyValue(player:Player,space:PlayerSpace,amount:Int)->Int{
//
//            return amount
//        }

}
 
 
  
 
 
 
 
 
