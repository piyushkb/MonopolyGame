 

import Foundation

/**
 Color assigned to a Monopoly property/space.
 
 - Note: All spaces on the board have a color, including utilities/railroads/chance/Go.
    - silver: utilities
    - blank: railroads
    - special: chance/community/etc.

 */
enum Color: String {
    case purple = "purple"
    case blue = "blue"
    case pink = "pink"
    case orange = "orange"
    case red = "red"
    case yellow = "yellow"
    case green = "green"
    case navy = "navy"
    case black = "black"
    case sliver = "silver" // utility
    case blank = "blank" // railroad
    case special = "special" // chance/community/etc.
    
    
    /**
     Color assigned to a Monopoly property/space.
     All spaces on the board have a color, including utilities/railroads/chance/Go.
     - Parameter color: The string representation of the color enum.
     - Note:
        - This is really only used when loading in properties from properties.txt
     
     */
    func fromString(color: String) -> Color {
        return Color(rawValue: color)!
    }
}
