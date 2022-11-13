
import SpriteKit


class BoardScene: SKScene {
   var movesRemaining:Int = 0
   
   var vc : GameViewController!
   var players = [Player]()
   
   override func didMove(to view: SKView) {
       
       self.addRollButton()
       self.addPeaces()
       
   }
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
       let node = self.getTappedNode(touches, scene: self, name: "rollButton")
      
              if(node.2) {
                  print("Roll Button Tapped")
                  vc.roll()
                  
                  let player = getActivePlayerAndNextPosition()
                  let diceTotal =  player.0.doubleDice.first!
                
                  self.movesRemaining = diceTotal
                  
                  if(isiPad()){
                      
                      DispatchQueue.main.asyncAfter(deadline: .now() + 3.7) {
                          self.movePiece()
                      }
                      
                  }else {
                      
                      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                          self.movePiece()
                      }
                  }
                  
                  
                 
                  
       }
   }
   
   func getActivePlayer() -> Player {
       let player = self.players.filter{$0.isActive}.first
       return player!
   }
  
   func movePiece() {
       
          let player = getActivePlayerAndNextPosition()
          
           let currentNode = getSkNode(name: player.1) // nextPosition
           
           let moveAction:SKAction = SKAction.move(to: currentNode.position, duration: 0.5)
           moveAction.timingMode = .easeOut
           let wait:SKAction = SKAction.wait(forDuration: 0.2)

           let runAction:SKAction = SKAction.run {

               player.0.setPlayerPosition(position: player.1) // move to next Position
               
               self.movesRemaining = self.movesRemaining - 1
              
               if(self.movesRemaining != 0) {
                   self.movePiece()
               }
               
               if(self.movesRemaining == 0) {
                   self.setNextPlayerActive()
               }
           }
           
           playMove()
           
           getSkNode(name: player.0.playerId).run( SKAction.sequence( [moveAction, wait, runAction]  ) )
           
    
   }
   
   func getActivePlayerAndNextPosition() -> (Player,String) {
       
       let currentPlayer = getActivePlayer()
       let currentSpace:String = currentPlayer.playerPosition //A0
       var spaceNumber:String = currentSpace //
       let firstCharacter:Character = spaceNumber.remove(at: spaceNumber.startIndex)

       let nextNumber:Int = Int(spaceNumber)! + 1
       let nextSpace:String = String(firstCharacter) + String(nextNumber)

       return (currentPlayer,nextSpace)
   }

   
   func setNextPlayerActive() {
       
       let playerId = self.getActivePlayer().getPlayerId().toInt()
       
       self.setAllPlayerDeactive()
    
       let nextplayerId  = playerId + 1
       
       var idFound = false
       
       for player in players {
           
           if(player.playerId == nextplayerId.description ) {
               idFound = true
               player.setPlayerActive()
               break
           }
       }
       
       if(!idFound) {
           self.players[0].setPlayerActive()
       }
       
       
   }
   
   func setAllPlayerDeactive() {
       
       for player in players {
           player.setPlayerDeActive()
       }
   }
   


}



extension BoardScene {
   
   func addRollButton() {
       
       let rollButton = SKSpriteNode(color: UIColor.red, size: CGSize(width: 80, height: 20))
       rollButton.anchorPoint = CGPoint(x: 0,y: 0)
       rollButton.position = getSkNode(name: "rollButtonSpace").position
       rollButton.zPosition = 2
       rollButton.name = "rollButton"
       rollButton.texture = SKTexture(imageNamed: "rollDice")
       self.addChild(rollButton)
     
   }
   
   func addPeaces() {
       
       let A0Node = getSkNode(name: Const.INITIAL_POSITION_PLAYER)
       
       for (index,player) in self.players.enumerated() {
           
           let peace = SKSpriteNode(color: UIColor.red, size: CGSize(width: 30, height: 15)) //
           peace.anchorPoint = CGPoint(x: 0,y: 0)
           peace.position.x = self.size.width  - getXPosition(index: index)
           peace.position.y =  A0Node.position.y
           peace.zPosition = 2
           peace.name = player.getPlayerId().description
           peace.texture = SKTexture(imageNamed: player.playerImage)
           self.addChild(peace)
           
       }
       
//        for player in self.players {
//
//            self.getTappedNode(<#T##touches: Set<UITouch>##Set<UITouch>#>, scene: <#T##SKScene#>, name: <#T##String#>)
//
//            let moveAction:SKAction = SKAction.move(to: node.position, duration: 0.5)
//            moveAction.timingMode = .easeOut
//            let wait:SKAction = SKAction.wait(forDuration: 0.2)
//
//            let runAction:SKAction = SKAction.run {
//
//                self.setThePlayerSpace(space: nextSpace, player:self.currentPlayer!)
//                self.movesRemaining = self.movesRemaining - 1
//
//                //In the kit here we would do things like check the space for particular properties
//                //i.e.   Do we draw a card, do we get money, do we win, do we lose a turn
//
//                self.movePiece()
//
//            }
//        }
      
   }
   
   func getSkNode(name:String) ->SKNode {
       return self.childNode(withName: name)!
   }
   
   func getSkSpriteNode(name:String) ->SKSpriteNode {
       return self.childNode(withName: name) as! SKSpriteNode
   }
   
   
}






















func getXPosition(index:Int) ->CGFloat {
   
   let position = 35.0
   
   switch index {
   case 0:
       return position

   case 1:
       return position * 1.5

   case 2:
       return position * 1.5 + 15

   default:
       return position * 1.5 + 30
   }
   
}


 
