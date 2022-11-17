

import Foundation

class Assets {
    
    private(set) var type: AssetType
    private(set) var utilities = [Utiliy]()
    
    init(type: AssetType, utilities: [Utiliy] = [Utiliy]()) {
        self.type = type
        self.utilities = utilities
    }
    
    func addUtility(utility: Utiliy){
        utilities.append(utility)
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



