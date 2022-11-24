
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
                break
                
            case .BANK_PAYS_DIVENDED:
                let des = "\(chanceCard.title)\n\(chanceCard.desc)"
                
                gameViewController.showChanceOrChestCard(title: "CHANCE", description: des, image: ConstImages.MAN, chanceIsGood: true) {
                    player.getPaid(amount: chanceCard.amount)
                }
            break
                
            case .GO_TO_JAIL:
                
                let des = "\(chanceCard.title)\n\(chanceCard.desc)"
                gameViewController.showChanceOrChestCard(title: "CHANCE", description: des, image: ConstImages.GO_TO_JAIL, chanceIsGood: false) {
                    player.sendToJail()
                }
                break
               
            }
        }
        
        if(space == .COMMUNITY_CHEST || space == .COMMUNITY_CHEST2  || space == .COMMUNITY_CHEST3 ) {
            
            let chestCard = CommunityChest.getCommunityChestCard()
           
            switch chestCard.type {
                
            case .DOCTORS_FEE:
                
                let des = "\(chestCard.title)\n\(chestCard.desc)"
                
                gameViewController.showChanceOrChestCard(title: "COMMUNITY CHEST", description: des, image: ConstImages.PAY_FEE, chanceIsGood: false) {
                    player.spend(moneyToSpend: chestCard.amount)
                }
                
                break
               
            case .SCHOOL_FEE:
                
                let des = "\(chestCard.title)\n\(chestCard.desc)"
                
                gameViewController.showChanceOrChestCard(title: "COMMUNITY CHEST", description: des, image: ConstImages.PAY_FEE, chanceIsGood: false) {
                    player.spend(moneyToSpend: chestCard.amount)
                }
                
                break
                
            case .INCOME_TAX_REFUND:
                playSound(soundName: AnimationJson.Chance)
                let des = "\(chestCard.title)\n\(chestCard.desc)"
                
                gameViewController.showChanceOrChestCard(title: "COMMUNITY CHEST", description: des, image: ConstImages.MAN, chanceIsGood: true) {
                    player.getPaid(amount: chestCard.amount)
                }
                
                break
                
            case .HOLIDAY_FUND_MATURES:
                playSound(soundName: AnimationJson.Chance)
                let des = "\(chestCard.title)\n\(chestCard.desc)"
                gameViewController.showChanceOrChestCard(title: "COMMUNITY CHEST", description: des, image: ConstImages.MAN, chanceIsGood: true) {
                    player.getPaid(amount: chestCard.amount)
                }
                break
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
                
                let e = UtilityCard.ELECTRICITY.self
                
                let des = "\(e.desc)\n\nMortgage $\(e.mortgage)"
                
                gameViewController.showUtilityCard(title: e.title, description: des, lottieJsonName: AnimationJson.Light) {
                     
                    for (index,item) in self.players.enumerated() {
                        if(item.assets.utilities.contains(.ELECTRICITY)){
                            if(item.assets.utilities.contains(.WATER_WORKS)){
                                //player having both electricity and water card
                                let rent = UtilityCard.getBothCardRent(rollValue: player.getRollValue())
                                self.players[index].getPaid(amount: rent)
                                player.spend(moneyToSpend: rent)
                                return
                            }else{
                                //player having only water card
                                let rent = UtilityCard.getSingleCardRent(rollValue: player.getRollValue())
                                self.players[index].getPaid(amount: rent)
                                player.spend(moneyToSpend: rent)
                                return
                            }
                        }
                    }
                    
                    player.assets.addUtility(utility: Utiliy.ELECTRICITY)
                    player.spend(moneyToSpend: UtilityCard.ELECTRICITY.amount)
                    
                }
                
            }
              
        }
        
        if(space == .WATER_WORKS){
             
            if player.assets.utilities.contains(.WATER_WORKS) {
                // do nothing
                return
            }else {
                
                let w = UtilityCard.WATER_WORKS.self
                
                let des = "\(w.desc)\n\nMortgage $\(w.mortgage)"
                
                gameViewController.showUtilityCard(title: w.title, description: des, lottieJsonName: AnimationJson.Water) {
                    
                    for item in self.players {
                        if(item.assets.utilities.contains(.WATER_WORKS)){
                            if(item.assets.utilities.contains(.ELECTRICITY)){
                                //player having both electricity and water card
                                let rent = UtilityCard.getBothCardRent(rollValue: player.getRollValue())
                                item.getPaid(amount: rent)
                                player.spend(moneyToSpend: rent)
                                return
                            }else{
                                //player having only water card
                                let rent = UtilityCard.getSingleCardRent(rollValue: player.getRollValue())
                                item.getPaid(amount: rent)
                                player.spend(moneyToSpend: rent)
                                return
                            }
                        }
                    }
                    
                    player.assets.addUtility(utility: Utiliy.WATER_WORKS)
                    player.spend(moneyToSpend: UtilityCard.WATER_WORKS.amount)
                    
                }
                
            }
        }
        
        if(space == .INCOME_TAX){
            player.spend(moneyToSpend: TaxCharges.INCOME_TAX)
        }
        
        if(space == .LUXARY_TAX){
            player.spend(moneyToSpend: TaxCharges.LUXURY_TAX)
        }
        
        
       
        //RailRoad --------
        
        func getAlreadyOwned(railRoad: RailRoad)->Bool {
            
            var alreadyOwned = false
            
            for item in players {
                if(item.assets.railRoads.contains(railRoad)){
                    alreadyOwned =  true
                    break
                }else{
                    alreadyOwned = false
                }
            }
            return alreadyOwned
        }
        
        func railRoadOp(railRoad: RailRoad, player: Player) -> Bool{
            var op = false
            for item in players {
                if(item.assets.railRoads.contains(railRoad)){
                    let countAllOwnedRailRoads = item.assets.railRoads.count
                    let rent = RailRoadCard.getRent(ownedStationsCount: countAllOwnedRailRoads)
                    item.getPaid(amount: rent)
                    player.spend(moneyToSpend: rent)
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
            
            gameViewController.showRailRoadCard(title: "READING RAILROAD", description: RailRoadCard.des, alreadyOwned: getAlreadyOwned(railRoad: .READING_RAILROAD )) {
                 
                if player.assets.railRoads.contains(.READING_RAILROAD) {
                    // do nothing
                    return
                }else {
                    let isAnyoneOwnedRailRoad =  railRoadOp(railRoad: RailRoad.READING_RAILROAD, player: player)
                    if(isAnyoneOwnedRailRoad) {
                        return
                    }else{
                        buyRailRoad(player: player, railroad: RailRoad.READING_RAILROAD)
                    }
                }
                
            }
            
        }
        if(space == .SHORT_LINE){
            
            gameViewController.showRailRoadCard(title: "SHORT LINE", description: RailRoadCard.des, alreadyOwned: getAlreadyOwned(railRoad: .SHORT_LINE )) {
           
                if player.assets.railRoads.contains(.SHORT_LINE) {
                    // do nothing
                    return
                }else {
                    let isAnyoneOwnedRailRoad =  railRoadOp(railRoad: RailRoad.SHORT_LINE, player: player)
                    if(isAnyoneOwnedRailRoad) {
                        return
                    }else{
                        buyRailRoad(player: player, railroad: RailRoad.SHORT_LINE)
                    }
                }
            }
           
        }
        if(space == .PENNSYLVANIA_RAILROAD){
            
            gameViewController.showRailRoadCard(title: "PENNSYLVANIA RAILROAD", description: RailRoadCard.des, alreadyOwned: getAlreadyOwned(railRoad: .PENNSYLVANIA_RAILROAD )) {
                
                
                if player.assets.railRoads.contains(.PENNSYLVANIA_RAILROAD) {
                    // do nothing
                    return
                }else {
                    let isAnyoneOwnedRailRoad =  railRoadOp(railRoad: RailRoad.PENNSYLVANIA_RAILROAD, player: player)
                    if(isAnyoneOwnedRailRoad) {
                        return
                    }else{
                        buyRailRoad(player: player, railroad: RailRoad.PENNSYLVANIA_RAILROAD)
                    }
                }
            }
        }
        if(space == .B_O_RAILROAD){
            
            gameViewController.showRailRoadCard(title: "B_O_RAILROAD", description: RailRoadCard.des, alreadyOwned: getAlreadyOwned(railRoad: .B_O_RAILROAD )) {
                
                
                if player.assets.railRoads.contains(.B_O_RAILROAD) {
                    // do nothing
                    return
                }else {
                    let isAnyoneOwnedRailRoad =  railRoadOp(railRoad: RailRoad.B_O_RAILROAD, player: player)
                    if(isAnyoneOwnedRailRoad) {
                        return
                    }else{
                        buyRailRoad(player: player, railroad: RailRoad.B_O_RAILROAD)
                    }
                }
            }
        }
        
        //------------- RailRoad
       
        
    }
}


