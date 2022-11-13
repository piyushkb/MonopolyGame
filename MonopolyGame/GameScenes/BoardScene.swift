 
import SpriteKit

 
class BoardScene: SKScene {
    
    
    var currentSpacePlayer1:String = "A0"
    var currentSpacePlayer2:String = "A0"

    var moves:Int = 4
    var movesRemaining:Int = 4
    var currentPlayer:Player!

    var player1Piece:SKSpriteNode = SKSpriteNode()
    var player2Piece:SKSpriteNode = SKSpriteNode()

    
    
    var vc : GameViewController!
    var players = [Player]()
    
    override func didMove(to view: SKView) {
        
        self.addPeaces()
        
        currentPlayer = self.players.first
        
        for node in children {

            if node.name == self.players[0].getPlayerId() {

                if let someNode:SKSpriteNode = node as? SKSpriteNode {
                    player1Piece = someNode
                }

            } else if node.name == self.players[1].getPlayerId() {

                if let someNode:SKSpriteNode = node as? SKSpriteNode {
                    player2Piece = someNode

                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let node = self.getTappedNode(touches, scene: self, name: "rollButton")
       
               if(node.2) {
                   print("Roll Button Tapped")
                   vc.roll()
                   //node.0!.texture = SKTexture(imageNamed: "hat")
                   
                   movesRemaining = moves
                   
                   DispatchQueue.main.asyncAfter(deadline: .now() + 3.7) {
                       self.movePiece()
                   }
                  
                   
        }
    }


    func movePiece() {

        if ( movesRemaining > 0) {

            let currentSpace:String = returnPlayerSpace(player: currentPlayer!)
            var spaceNumber:String = currentSpace
            let firstCharacter:Character = spaceNumber.remove(at: spaceNumber.startIndex)

            let nextNumber:Int = Int(spaceNumber)! + 1
            let nextSpace:String = String(firstCharacter) + String(nextNumber)

            for node in children {

                if (node.name == nextSpace) {

                    let moveAction:SKAction = SKAction.move(to: node.position, duration: 0.5)
                    moveAction.timingMode = .easeOut
                    let wait:SKAction = SKAction.wait(forDuration: 0.2)

                    let runAction:SKAction = SKAction.run {

                        self.setThePlayerSpace(space: nextSpace, player:self.currentPlayer!)
                        self.movesRemaining = self.movesRemaining - 1

                        //In the kit here we would do things like check the space for particular properties
                        //i.e.   Do we draw a card, do we get money, do we win, do we lose a turn

                        self.movePiece()

                    }

                    playMove()
                    returnPlayerPiece(player: self.currentPlayer!).run( SKAction.sequence( [moveAction, wait, runAction]  ) )


                }
            }


        } else {

          //   next players turns

            
            if (currentPlayer.playerId == self.players[0].playerId) {

                currentPlayer = players[1]


            } else if (currentPlayer.playerId == self.players[1].playerId) {

                currentPlayer = players[0]
            }
            

        }



    }

    func returnPlayerPiece (player:Player!) -> SKSpriteNode {

        var playerPiece:SKSpriteNode = SKSpriteNode()


        if (player.playerId == self.players[0].playerId) {

            playerPiece = player1Piece


        } else if (player.playerId == self.players[1].playerId) {

            playerPiece = player2Piece
        }
        
        return playerPiece
    }


    func setThePlayerSpace(space:String, player:Player) {


        if (player.playerId == self.players[0].playerId) {

             currentSpacePlayer1 = space


        } else if (player.playerId == self.players[1].playerId) {

             currentSpacePlayer2 = space
        }


    }


    func returnPlayerSpace( player:Player ) -> String {

        var space:String = ""

        if (player.playerId == self.players[0].playerId) {

            space = currentSpacePlayer1


        } else if (player.playerId == self.players[1].playerId) {

            space = currentSpacePlayer2
        }


        return space
    }


     
}



extension BoardScene {
    
    func addPeaces() {
        
        let A0Node = getNode(name: "A0")
        
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
    
    func getNode(name:String) ->SKNode {
        return self.childNode(withName: name)!
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
