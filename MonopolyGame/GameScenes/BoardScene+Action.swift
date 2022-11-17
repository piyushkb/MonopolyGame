
import UIKit


extension BoardScene {
    
    func finalAction(space:PlayerSpace, player:Player) {
        
        if(space == .CHANCE || space == .CHANCE2  || space == .CHANCE3 ) {
            vc.opneChanceVC()
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
                            var rent = UtilityCard.getBothCardRent(rollValue: player.getRollValue())
                            players[index].getPaid(amount: rent)
                            return
                        }else{
                            //player having only water card
                            var rent = UtilityCard.getSingleCardRent(rollValue: player.getRollValue())
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
                            var rent = UtilityCard.getBothCardRent(rollValue: player.getRollValue())
                            item.getPaid(amount: rent)
                            return
                        }else{
                            //player having only water card
                            var rent = UtilityCard.getSingleCardRent(rollValue: player.getRollValue())
                            item.getPaid(amount: rent)
                            return
                        }
                    }
                }
                
                player.assets.addUtility(utility: Utiliy.WATER_WORKS)
                player.spend(moneyToSpend: UtilityCard.WATER_WORKS.amount)
                
            }
              
        }
    }
}
