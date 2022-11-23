class Chances {
    
    static private(set) var chancesList = [ChancesType.SPEEDING_FINE, ChancesType.BANK_PAYS_DIVENDED, ChancesType.GO_TO_JAIL]
    
    
    static func getChanceCard() -> ChancesCardModel{
//        
//        chancesList[0] =  chancesList[1]
//        chancesList[1] =  chancesList[2]
//        chancesList[2] =  chancesList[0]
//        
        switch chancesList[2] {
        case .SPEEDING_FINE:
            return ChancesCardModel(type: .SPEEDING_FINE, title: ChancesCard.SPEEDING_FINE.title, desc: ChancesCard.SPEEDING_FINE.desc, amount: ChancesCard.SPEEDING_FINE.amount, image: ConstImages.PAY_FEE)
        case .BANK_PAYS_DIVENDED:
            return ChancesCardModel(type: .BANK_PAYS_DIVENDED, title: ChancesCard.BANK_PAYS_DIVENDED.title, desc: ChancesCard.BANK_PAYS_DIVENDED.desc, amount: ChancesCard.BANK_PAYS_DIVENDED.amount, image: ConstImages.MAN)
        case .GO_TO_JAIL:
            return ChancesCardModel(type: .GO_TO_JAIL, title: ChancesCard.GO_TO_JAIL.title, desc: ChancesCard.GO_TO_JAIL.desc, amount: ChancesCard.GO_TO_JAIL.amount, image: ConstImages.GO_TO_JAIL)
        }
    }
}

enum ChancesType: String{
    case SPEEDING_FINE
    case BANK_PAYS_DIVENDED
    case GO_TO_JAIL
}
    
class ChancesCardModel{
        let type: ChancesType
        let title: String
        let desc : String
        let amount: Int
        let image :String
        
    init(type: ChancesType, title: String, desc: String, amount: Int,image:String) {
        self.type = type
        self.title = title
        self.desc = desc
        self.amount = amount
        self.image = image
    }
}

    

