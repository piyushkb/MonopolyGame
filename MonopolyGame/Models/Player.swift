 
import UIKit
import SpriteKit

class Player {
    
    var turnsInJail = 0
    var playerImage: String
    var moneySymbol = "$"
    
    private(set) var totalMoney = 0
    private(set) var playerName: String
    private(set) var playerPosition:PlayerSpace = .GO
    private(set) var dice1: Int?
    private(set) var dice2: Int?
    private(set) var playerId: String
    private(set) var inJail = false
    private(set) var isActive = false
    private(set) var doubleDice = [Int]()
    private(set) var assets: Assets
    
   

    init(assets:Assets = Assets(type: .NONE, utilities: []), isActive:Bool,playerImage:String,playerId:String,totalMoney:Int,playerName: String, playerPosition: PlayerSpace) {
        self.playerName = playerName
        self.playerPosition = playerPosition
        self.totalMoney = totalMoney
        self.playerId = playerId
        self.playerImage = playerImage
        self.isActive = isActive
        self.assets = assets
    }
    
    
    func rollDice() {
        
        dice1 = Int.random(in: 1...6)
        dice2 = Int.random(in: 1...6)
        
        var total = dice1! + dice2!
        print("Totallllllllllllllllll  \(total)")
        //total = 2
        if(doubleDice.isEmpty){
            doubleDice.append(total)
        }else{
            doubleDice[0] = total
        }
       // doubleDice.append(total)
//        if(dice1 == dice2){
//           // doubleDice.append(total)
//            doubleDice.append(total)
//        }else {
//            doubleDice.removeAll()
//           // doubleDice.append(total)
//            doubleDice.append(total)
//        }
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
    
    
    func moveToJailPosition() {
      
        let jailNode = boardScene.getSkNode(name: PlayerSpace.JAIL_VISITING.rawValue)
        
        let moveAction:SKAction = SKAction.move(to: jailNode.position, duration: 0.5)
        moveAction.timingMode = .easeInEaseOut
        let wait:SKAction = SKAction.wait(forDuration: 0.2)
        let runAction:SKAction = SKAction.run {
            self.setPlayerPosition(position: PlayerSpace(rawValue: PlayerSpace.JAIL_VISITING.rawValue)!) // move to next
        }
        
        playMove()
        boardScene.getSkNode(name: self.playerId).run( SKAction.sequence( [moveAction, wait, runAction]  ) )
    }
    
    func hideTopDialog() {
//        let  topVC =  UIApplication.topViewController()!
//
//        var className = NSStringFromClass(topVC.classForCoder)
//
//        print(className)
//
//        if(className != "MonopolyGame.GameViewController") {
//            UIApplication.topViewController()!.dismiss(animated: true)
//        }
    }
   
    func spend(moneyToSpend: Int) {
        
        print("Spening")
        
        let haveEnoughMoney = LogicsHandler.shared.haveMoneyToBuy(player: self, spndingAmount: moneyToSpend)
        
        let haveEnoughAssets = LogicsHandler.shared.haveEnoughAssets(player: self, spndingAmount: moneyToSpend)
        
        if(!haveEnoughMoney) {
            
            if(haveEnoughAssets) {
                
                let msg = "You don't have enough Money,You need to sell your Assets?"
                
                showConfirmationAlertGlobal(noText: "Quit Game" , message: msg) { value in
                    
                    if value {
                        
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AssetsVC") as! AssetsVC
                        vc.player = self
                        vc.mustSpend = true
                        vc.spndingAmount = moneyToSpend
                        vc.modalTransitionStyle = .coverVertical
                        vc.modalPresentationStyle = .overFullScreen
                        UIApplication.topViewController()!.present(vc, animated: true)
                        
                        vc.completionHandler = {
                            self.spentMoney(moneyToSpend:moneyToSpend)
                        }
                        
                    }else{
                        playSound(soundName: AnimationJson.SAD)
                        self.removePlayer()
                    }
                    reloadTable() // show asset Contoller
                }
               
              
            }else {
                   
                    hideTopDialog()
                showOkeyAlertWithCallBackAnyWhere(message:  "\(playerName) Got Bank Currepted.. " ) {
                    
                        self.removePlayer()
                     
                    }
                    playSound(soundName: AnimationJson.SAD)
                }
        }else {
            spentMoney(moneyToSpend:moneyToSpend)
        }
       
        checkWin()
      
    }
    
    func spentMoney(moneyToSpend:Int) {
        
        totalMoney -= moneyToSpend
        playSound(soundName: AnimationJson.Tax)
        reloadTable()
    }
    
    func removePlayer(){
        
        var playerIndex = 0
        for (index,item) in gameViewController.players.enumerated() {
            
            if(item.playerId == self.playerId) {
                playerIndex = index
                break
            }
        }
        gameViewController.players.remove(at: playerIndex)
        reloadTable()
        self.checkWin()
    }
    
    func checkWin() {
        
        if(gameViewController.players.count == 1) {
            showWinnerScreen()
        }
    }
    func getPaid(amount: Int) {
        print("Paidddd")
        // Get paid (e.g. rent)
        totalMoney += amount
        reloadTable()
        playSound(soundName: AnimationJson.Credit)
    }
    
    func getRollValue()  -> Int{
        // Get paid (e.g. rent)
        return self.dice1! + self.dice2!
    }
    
  
    func sendToJail() {
        inJail = true
        self.moveToJailPosition()
       // setPlayerPosition(position: .GO_TO_JAIL)
        
        // send player to jail // show card to ask pay 50$ to get out from jail
        //otherwise user have to wait until he gets double
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
    func getPlayerPosition() -> PlayerSpace
    {
        return self.playerPosition
    }
    
    func setPlayerPosition(position:PlayerSpace)
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
