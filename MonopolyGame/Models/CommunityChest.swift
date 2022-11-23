class CommunityChest {
    
    static private(set) var communityChestList = [CommunityChestType.DOCTORS_FEE, CommunityChestType.SCHOOL_FEE, CommunityChestType.INCOME_TAX_REFUND, CommunityChestType.HOLIDAY_FUND_MATURES]
    
    
    static func getCommunityChestCard() -> CommunityChestModel{
        
        communityChestList[0] =  communityChestList[1]
        communityChestList[1] =  communityChestList[2]
        communityChestList[2] =  communityChestList[3]
        communityChestList[3] =  communityChestList[0]
        
        switch communityChestList[0] {
        case .SCHOOL_FEE:
            return CommunityChestModel(type: CommunityChestType.SCHOOL_FEE, title: CommunityChestCard.SCHOOL_FEE.title, desc: CommunityChestCard.SCHOOL_FEE.desc, amount: CommunityChestCard.SCHOOL_FEE.amount)
        case .DOCTORS_FEE:
            return CommunityChestModel(type: CommunityChestType.DOCTORS_FEE, title: CommunityChestCard.DOCTORS_FEE.title, desc: CommunityChestCard.DOCTORS_FEE.desc, amount: CommunityChestCard.DOCTORS_FEE.amount)
        case .INCOME_TAX_REFUND:
            return CommunityChestModel(type: CommunityChestType.INCOME_TAX_REFUND, title: CommunityChestCard.INCOME_TAX_REFUND.title, desc: CommunityChestCard.INCOME_TAX_REFUND.desc, amount: CommunityChestCard.INCOME_TAX_REFUND.amount)
        case .HOLIDAY_FUND_MATURES:
            return CommunityChestModel(type: CommunityChestType.HOLIDAY_FUND_MATURES, title: CommunityChestCard.HOLIDAY_FUND_MATURES.title, desc: CommunityChestCard.HOLIDAY_FUND_MATURES.desc, amount: CommunityChestCard.HOLIDAY_FUND_MATURES.amount)
        }
    }
    
    enum CommunityChestType: String{
        case DOCTORS_FEE
        case SCHOOL_FEE
        case INCOME_TAX_REFUND
        case HOLIDAY_FUND_MATURES
    }
    
    class CommunityChestModel{
        let type: CommunityChestType
        let title: String
        let desc : String
        let amount: Int
        
        init(type: CommunityChestType, title: String, desc: String, amount: Int) {
            self.type = type
            self.title = title
            self.desc = desc
            self.amount = amount
        }
    }
    
    
    
}
