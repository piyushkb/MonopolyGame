

import Foundation

class Assets {
    
    private(set) var type: AssetType
    private(set) var utilities = [Utiliy]()
    private(set) var railRoads = [RailRoad]()
    
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


