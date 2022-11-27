

import Foundation

class Assets {
    
    static let UtilityText = "Utility"
    static let RailRoadText = "Rail Roads"
    static let LandsText = "Land"
    
    
    private(set) var type: AssetType
    private(set) var utilities = [Utiliy]()
    private(set) var railRoads = [RailRoad]()
    private(set) var lands =  [PropertyCard]()
    private(set) var houses = [PropertyCard]()
    private(set) var hotels = [PropertyCard]()
    
    init(type: AssetType, utilities: [Utiliy] = [Utiliy]()) {
        self.type = type
        self.utilities = utilities
    }
    
    func addLand(prpertyCard:PropertyCard){
        lands.append(prpertyCard)
    }
     
    func addUtility(utility: Utiliy){
        utilities.append(utility)
    }
    
    func addRailRoad(railroad: RailRoad){
        railRoads.append(railroad)
    }
    func removeAsset(player:Player,assetName:String,index:Int) {
        
        if(assetName == Assets.UtilityText) {
            utilities.remove(at: index)
            player.getPaid(amount: UtilityCard.WATER_WORKS.sellValue)
        }else if(assetName == Assets.RailRoadText) {
            railRoads.remove(at: index)
            player.getPaid(amount: RailRoadCard.sellValue)
        }else if(assetName == Assets.LandsText) {
            player.getPaid(amount: lands[index].getSellValue())
            boardScene.removeFlag(space: lands[index].space)
            lands.remove(at: index)
           
        }
    }
    
    func alreadyOwned(space:PlayerSpace) -> Bool {
        
        var alreadyOwned = false
        for player in gameViewController.players {
          
            let allProperties = player.assets.lands + player.assets.houses + player.assets.hotels
            
            for property in allProperties {
                if property.space == space {
                    alreadyOwned  = true
                    break
                }
            }
        }
        return alreadyOwned
    }
    
    func isOwnedByMe(space:PlayerSpace) -> Bool {
        
        var alreadyOwnedByMe = false
        
        let allProperties = self.lands + self.houses + self.hotels
        
        for property in allProperties {
            if property.space == space {
                alreadyOwnedByMe  = true
                break
            }
        }
       return alreadyOwnedByMe
    }
    
    func isOwnedByOther(space:PlayerSpace) -> Bool {
        
        let propertyCard = getPropertyCard(space: space)
        
        var playerIndex = -1
        
        for (index,player) in gameViewController.players.enumerated() {
            
            let lands = player.assets.lands
            
            let x = lands.filter({$0.space == space})
            
            if(x.count > 0) {
                playerIndex = index
                break
            }
        }
        
        if(playerIndex == -1) {
            return false
        }else {
            return true
        }
    }
    
    func getProperties() ->( [PropertyCard],[PropertyCard], [PropertyCard] )
    {
        return (self.lands,self.houses,self.hotels)
    }
    
    
    func getAllAssetsTypes()->[String] {
        
        var types = [String]()
        
        if(utilities.count > 0) {
            types.append(Assets.UtilityText)
        }
        
        if(railRoads.count > 0) {
            types.append(Assets.RailRoadText)
        }
        
        if(lands.count > 0) {
            types.append(Assets.LandsText)
        }
        
        return  types
    }
    
    func getTotalValueOfAllAssets()->Int {
        
        
        var utilityValue = UtilityCard.WATER_WORKS.sellValue * utilities.count
        
        var railRoadValue = RailRoadCard.sellValue * railRoads.count
         
        var landsValue = 0
        
        for item in lands {
            landsValue += item.getSellValue()
        }
        
//        for item in houses {
//            landsValue += item.getSellValue()
//        }
        
        // hotels and houses also in v2
        
        return utilityValue + railRoadValue + landsValue
        
    }
    
}

enum AssetType: String {
    case HOTEL
    case HOUSE
    case WATER_WORKS
    case ELECTRICITY
    case RAIL
    case CHNACE
    case CHEST
    case JAIL
    case NONE
}

enum Utiliy: String{
    case WATER_WORKS
    case ELECTRICITY
}

enum RailRoad: String{
    case READING_RAILROAD
    case B_O_RAILROAD
    case PENNSYLVANIA_RAILROAD
    case SHORT_LINE
}


 
