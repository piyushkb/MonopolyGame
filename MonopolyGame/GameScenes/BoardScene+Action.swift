
import UIKit


extension BoardScene {
    
    
    func finalAction(space:PlayerSpace, player:Player) {
        
        if(space == .CHANCE || space == .CHANCE2  || space == .CHANCE3 ) {
           
            let chanceCard = Chances.getChanceCard()
        
            switch chanceCard.type {
                
            case ChancesType.SPEEDING_FINE:
                
                let des = "\(chanceCard.title)\n\(chanceCard.desc)"
                
                gameViewController.showChanceOrChestCard(title: "CHANCE", description: des, image: ConstImages.PAY_FEE, chanceIsGood: false) {
                    player.spend(moneyToSpend: chanceCard.amount)
                }
                
            case .BANK_PAYS_DIVENDED:
                let des = "\(chanceCard.title)\n\(chanceCard.desc)"
                
                gameViewController.showChanceOrChestCard(title: "CHANCE", description: des, image: ConstImages.MAN, chanceIsGood: true) {
                    player.getPaid(amount: chanceCard.amount)
                }
            
                
            case .GO_TO_JAIL:
                
                let des = "\(chanceCard.title)\n\(chanceCard.desc)"
                gameViewController.showChanceOrChestCard(title: "CHANCE", description: des, image: ConstImages.GO_TO_JAIL, chanceIsGood: false) {
                    player.sendToJail()
                }
               
            }
        }
        
        if(space == .COMMUNITY_CHEST || space == .COMMUNITY_CHEST2  || space == .COMMUNITY_CHEST3 ) {
            
            let chestCard = CommunityChest.getCommunityChestCard()
            
            switch chestCard.type {
                
            case .DOCTORS_FEE:
                //show card
                player.spend(moneyToSpend: chestCard.amount)
            case .SCHOOL_FEE:
                //show card
                player.spend(moneyToSpend: chestCard.amount)
            case .INCOME_TAX_REFUND:
                //show card
                player.getPaid(amount: chestCard.amount)
            case .HOLIDAY_FUND_MATURES:
                //show card
                player.getPaid(amount: chestCard.amount)
            }
            
        }
        
        
        if(space == .ORIENTAL_AVENUE) {
            vc.opneCardVC()
        }
        
        if(space == .ELECTRICITY){
             
            if player.assets.utilities.contains(.ELECTRICITY) {
                // do nothing
                return
            }else {
                
                for (index,item) in players.enumerated() {
                    if(item.assets.utilities.contains(.ELECTRICITY)){
                        if(item.assets.utilities.contains(.WATER_WORKS)){
                            //player having both electricity and water card
                            let rent = UtilityCard.getBothCardRent(rollValue: player.getRollValue())
                            players[index].getPaid(amount: rent)
                            return
                        }else{
                            //player having only water card
                            let rent = UtilityCard.getSingleCardRent(rollValue: player.getRollValue())
                            players[index].getPaid(amount: rent)
                            return
                        }
                    }
                }
                
                player.assets.addUtility(utility: Utiliy.ELECTRICITY)
                player.spend(moneyToSpend: UtilityCard.ELECTRICITY.amount)
                
            }
              
        }
        
        if(space == .WATER_WORKS){
             
            if player.assets.utilities.contains(.WATER_WORKS) {
                // do nothing
                return
            }else {
                
                for item in players {
                    if(item.assets.utilities.contains(.WATER_WORKS)){
                        if(item.assets.utilities.contains(.ELECTRICITY)){
                            //player having both electricity and water card
                            let rent = UtilityCard.getBothCardRent(rollValue: player.getRollValue())
                            item.getPaid(amount: rent)
                            return
                        }else{
                            //player having only water card
                            let rent = UtilityCard.getSingleCardRent(rollValue: player.getRollValue())
                            item.getPaid(amount: rent)
                            return
                        }
                    }
                }
                
                player.assets.addUtility(utility: Utiliy.WATER_WORKS)
                player.spend(moneyToSpend: UtilityCard.WATER_WORKS.amount)
                
            }
        }
        
        if(space == .INCOME_TAX){
            player.spend(moneyToSpend: TaxCharges.INCOME_TAX)
        }
        
        if(space == .LUXARY_TAX){
            player.spend(moneyToSpend: TaxCharges.LUXURY_TAX)
        }
        
        //RailRoad --------
        
        func railRoadOp(railRoad: RailRoad) -> Bool{
            var op = false
            for item in players {
                if(item.assets.railRoads.contains(railRoad)){
                    let countAllOwnedRailRoads = item.assets.railRoads.count
                    let rent = RailRoadCard.getRent(ownedStationsCount: countAllOwnedRailRoads)
                    item.getPaid(amount: rent)
                    op =  true
                    break
                }else{
                    op = false
                }
            }
            return op
        }
        
        func buyRailRoad(player: Player, railroad: RailRoad){
            //show card and ask first to buy or not the railroad
            player.assets.addRailRoad(railroad: railroad)
            player.spend(moneyToSpend: RailRoadCard.amount)
        }
        
        if(space == .READING_RAILROAD){
            if player.assets.railRoads.contains(.READING_RAILROAD) {
                // do nothing
                return
            }else {
                let isAnyoneOwnedRailRoad =  railRoadOp(railRoad: RailRoad.READING_RAILROAD)
                if(isAnyoneOwnedRailRoad) {
                    return
                }else{
                    buyRailRoad(player: player, railroad: RailRoad.READING_RAILROAD)
                }
            }
        }
        if(space == .SHORT_LINE){
            if player.assets.railRoads.contains(.SHORT_LINE) {
                // do nothing
                return
            }else {
                let isAnyoneOwnedRailRoad =  railRoadOp(railRoad: RailRoad.SHORT_LINE)
                if(isAnyoneOwnedRailRoad) {
                    return
                }else{
                    buyRailRoad(player: player, railroad: RailRoad.SHORT_LINE)
                }
            }
        }
        if(space == .PENNSYLVANIA_RAILROAD){
            if player.assets.railRoads.contains(.PENNSYLVANIA_RAILROAD) {
                // do nothing
                return
            }else {
                let isAnyoneOwnedRailRoad =  railRoadOp(railRoad: RailRoad.PENNSYLVANIA_RAILROAD)
                if(isAnyoneOwnedRailRoad) {
                    return
                }else{
                    buyRailRoad(player: player, railroad: RailRoad.PENNSYLVANIA_RAILROAD)
                }
            }
        }
        if(space == .B_O_RAILROAD){
            if player.assets.railRoads.contains(.B_O_RAILROAD) {
                // do nothing
                return
            }else {
                let isAnyoneOwnedRailRoad =  railRoadOp(railRoad: RailRoad.B_O_RAILROAD)
                if(isAnyoneOwnedRailRoad) {
                    return
                }else{
                    buyRailRoad(player: player, railroad: RailRoad.B_O_RAILROAD)
                }
            }
        }
        
        //------------- RailRoad
        
        
        
        
        
    }
}


