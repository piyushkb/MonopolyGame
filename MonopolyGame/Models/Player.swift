 
import UIKit

class Player {
    
    var turnsInJail = 0
    var playerImage: String
    var moneySymbol = "$"
    private(set) var totalMoney = 0
    private(set) var playerName: String
    private(set) var playerPosition = Const.INITIAL_POSITION_PLAYER
    private(set) var dice1: Int?
    private(set) var dice2: Int?
    private(set) var playerId: String
    private(set) var inJail = false
    private(set) var isActive = false
    private(set) var doubleDice = [Int]()
    
  
    
    init(isActive:Bool,playerImage:String,playerId:String,totalMoney:Int,playerName: String, playerPosition: String) {
        self.playerName = playerName
        self.playerPosition = playerPosition
        self.totalMoney = totalMoney
        self.playerId = playerId
        self.playerImage = playerImage
        self.isActive = isActive
    }
    
    
    func rollDice() {
        
        dice1 = Int.random(in: 1...6)
        dice2 = Int.random(in: 1...6)
        
        let total = dice1! + dice2!
        
        if(dice1 == dice2){
            doubleDice.append(total)
        }else {
            doubleDice.removeAll()
            doubleDice.append(total)
        }
    }
     
    
    func clearTotalScore() {
        totalMoney = 0
    }
    
    func clearStateAfterRound() {
//        dice1 = nil
//        dice2 = nil
//        previousDice = nil
//
//        clearRoundScore()
    }
    
    func move(spaces: Int) {
        // move player to new location
    }
    
    func spend(moneyToSpend: Int) {
        // spend money
    }
    
    func getPaid(amount: Int) {
        // Get paid (e.g. rent)
    }
    
}
  

 
extension  Player
{
   
    func isPlayerActive() -> Bool
    {
        return self.isActive
    }
    
    func setPlayerDeActive()
    {
       self.isActive = false
    }
    
    func setPlayerActive()
    {
       self.isActive = true
    }
    
    func getPlayerId() -> String
    {
        return self.playerId
    }
    func getPlayerPosition() -> String
    {
        return self.playerPosition
    }
    
    func setPlayerPosition(position:String)
    {
        self.playerPosition = position
    }
    
    func setName(name:String) 
    {
       self.playerName = name
    }
    
    func setTotalMoney(totalMoney:Int)
    {
       self.totalMoney = totalMoney
    }
    
    func getToalMoney()->Int
    {
       return Int(self.totalMoney)
    }
    
    func getTotalMoneyString()->String
    {
        return self.totalMoney.description + moneySymbol
    }
    
    
    func getPlayerName() -> String
    {
        return self.playerName
    }
     
    func getImage() -> UIImage
    {
        return UIImage(named: self.playerImage)!
    }
     
    
}
