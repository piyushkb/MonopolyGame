

import Foundation

class Assets {
    
    static let UtilityText = "Utility"
    static let RailRoadText = "Rail Roads"
    static let LandsText = "Lands"
    static let HouseText = "Houses"
    
    
    private(set) var type: AssetType
    private(set) var utilities = [Utiliy]()
    private(set) var railRoads = [RailRoad]()
    private(set) var lands = [AnyObject]()
    private(set) var houses = [AnyObject]()
    
    init(type: AssetType, utilities: [Utiliy] = [Utiliy]()) {
        self.type = type
        self.utilities = utilities
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
            lands.remove(at: index)
        }
        else if(assetName == Assets.HouseText) {
            houses.remove(at: index)
        }
        
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
        
        if(houses.count > 0) {
            types.append(Assets.HouseText)
        }
        
        return  types
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


