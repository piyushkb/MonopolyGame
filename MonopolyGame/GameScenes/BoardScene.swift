
import SpriteKit


var vc : GameViewController!

class BoardScene: SKScene {
   var movesRemaining:Int = 0
   
  
    var players =  [Player]()

   
   override func didMove(to view: SKView) {
       
       self.addRollButton()
       self.addPeaces()
       
   }
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
       let node = self.getTappedNode(touches, scene: self, name: "rollButton")
      
              if(node.2) {
                  disableTouch(view: vc.view)
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

               player.0.setPlayerPosition(position: PlayerSpace(rawValue: player.1)!) // move to next Position
               
               self.movesRemaining = self.movesRemaining - 1
              
               if(self.movesRemaining != 0) {
                   self.movePiece()
               }
               
               if(self.movesRemaining == 0) {
                   self.onReachAtPosition(player: player.0)
                   self.setNextPlayerActive()
               }
           }
           
           playMove()
           
           getSkNode(name: player.0.playerId).run( SKAction.sequence( [moveAction, wait, runAction]  ) )
           
    
   }
   
   func getActivePlayerAndNextPosition() -> (Player,String) {
       
       let currentPlayer = getActivePlayer()
       let currentSpace:String = currentPlayer.playerPosition.rawValue //A0
       var spaceNumber:String = currentSpace //
       let firstCharacter:Character = spaceNumber.remove(at: spaceNumber.startIndex)

       let nextNumber:Int = Int(spaceNumber)! + 1
       let nextSpace:String = String(firstCharacter) + String(nextNumber)

       return (currentPlayer,nextSpace)
   }

    func onReachAtPosition(player:Player) {
        
        let playerSpace = player.playerPosition
        
        switch playerSpace {
            
        case .GO :
            self.handelPosition(space: playerSpace, player: player)
            break
        case .MEDITER_RANEAN:
            self.handelPosition(space: playerSpace, player: player)
        case .COMMUNITY_CHEST:
            self.handelPosition(space: playerSpace, player: player)
        case .BALTIC_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .INCOME_TAX:
            self.handelPosition(space: playerSpace, player: player)
        case .READING_RAILROAD:
            self.handelPosition(space: playerSpace, player: player)
        case .ORIENTAL_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .CHANCE:
            self.handelPosition(space: playerSpace, player: player)
        case .VERMONT_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .CONNECTICUT_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .JAIL_VISITING:
            self.handelPosition(space: playerSpace, player: player)
        case .ST_CHARLES:
            self.handelPosition(space: playerSpace, player: player)
        case .ELECTRICITY:
            self.handelPosition(space: playerSpace, player: player)
        case .STATUS_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .VIRGINIA_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .PENNSYLVANIA_RAILROAD:
            self.handelPosition(space: playerSpace, player: player)
        case .ST_JAMES_PLACE:
            self.handelPosition(space: playerSpace, player: player)
        case .COMMUNITY_CHEST2:
            self.handelPosition(space: playerSpace, player: player)
        case .TENNESSEE_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .NEW_YOURK_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .FREE_PARKING:
            self.handelPosition(space: playerSpace, player: player)
        case .KENTUCKY_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .CHANCE2:
            self.handelPosition(space: playerSpace, player: player)
        case .INDIANA_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .ILLINOIS_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .B_O_RAILROAD:
            self.handelPosition(space: playerSpace, player: player)
        case .ATLANTIC_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .VENTINOR_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .WATER_WORKS:
            self.handelPosition(space: playerSpace, player: player)
        case .MARVIN_GARDENS:
            self.handelPosition(space: playerSpace, player: player)
        case .GO_TO_JAIL:
            self.handelPosition(space: playerSpace, player: player)
        case .PACIFIC_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .NORTH_CAROLINA_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .COMMUNITY_CHEST3:
            self.handelPosition(space: playerSpace, player: player)
        case .PENNSYLVANIA_AVENUE:
            self.handelPosition(space: playerSpace, player: player)
        case .SHORT_LINE:
            self.handelPosition(space: playerSpace, player: player)
        case .CHANCE3:
            self.handelPosition(space: playerSpace, player: player)
        case .PARK_PLACE:
            self.handelPosition(space: playerSpace, player: player)
        case .LUXARY_TAX:
            self.handelPosition(space: playerSpace, player: player)
        case .BOARD_WALK:
            self.handelPosition(space: playerSpace, player: player)
        }
    }
   
    
    func handelPosition(space:PlayerSpace,player:Player) {
        
        print(space)
        
        if(space == .ORIENTAL_AVENUE) {
            vc.opneCardVC()
        }
        
        if(space == .JAIL_VISITING || space == .GO_TO_JAIL) {
            print("Jail")
            vc.showLottieAnimation(json: AnimationJson.JAIL, completion: {
                
            })
            playSound(soundName: AnimationJson.JAIL)
        }
        
        if(space == .COMMUNITY_CHEST || space == .COMMUNITY_CHEST2  || space == .COMMUNITY_CHEST3 ) {
            print("chest")
            vc.showLottieAnimation(json: AnimationJson.Chest, completion: {
                self.finalAction(space: space, player: player)
            })
            playSound(soundName: AnimationJson.Chest)
        }
        
        if(space == .CHANCE || space == .CHANCE2  || space == .CHANCE3 ) {
            print("chance")
            vc.showLottieAnimation(json: AnimationJson.Chance, completion: {
                self.finalAction(space: space, player: player)
            })
            playSound(soundName: AnimationJson.Chance)
        }
        
        if(space == .INCOME_TAX || space == .LUXARY_TAX ) {
            print("tax")
            vc.showLottieAnimation(json: AnimationJson.Tax, completion: {
                self.finalAction(space: space, player: player)
            })
            playSound(soundName: AnimationJson.Tax)
        }
        
        
        if(space == .READING_RAILROAD || space == .PENNSYLVANIA_RAILROAD || space == .B_O_RAILROAD || space == .SHORT_LINE) {
            print("Rail")
            vc.showLottieAnimation(json: AnimationJson.Rail, completion: {
                self.finalAction(space: space, player: player)
            })
            playSound(soundName: AnimationJson.Rail)
        }
        
        
        if(space == .ELECTRICITY) {
            print("electic")
            vc.showLottieAnimation(json: AnimationJson.Light, completion: {
                self.finalAction(space: space, player: player)
            })
            playSound(soundName: AnimationJson.Light)
        }
        
        if(space == .WATER_WORKS) {
            print("water")
            vc.showLottieAnimation(json: AnimationJson.Water, completion: {
                self.finalAction(space: space, player: player)
            })
            playSound(soundName: AnimationJson.Water)
        }
        
        
        if(space == .FREE_PARKING ) {
            print("Parking")
            vc.showLottieAnimation(json: AnimationJson.Parking, completion: {
                
            })
            playSound(soundName: AnimationJson.Parking)
        }
        
        
        enableTouch(view:  vc.view)
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
       
       let A0Node = getSkNode(name: PlayerSpace.GO.rawValue)
       
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

 

func reloadTable() {
    
    DispatchQueue.main.async {
        vc.tableView.reloadData()
    }
}
