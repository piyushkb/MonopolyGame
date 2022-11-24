 
class LogicsHandler {
    
    static let shared = LogicsHandler()


    func haveMoneyToBuy(player:Player,buyAmount:Int)->Bool {
        
        var tempMoney = player.totalMoney
        tempMoney = tempMoney - buyAmount
       
        print(tempMoney)
        
        print(player.totalMoney)
        
        
        if(tempMoney < 0) {
            return false // pese nhi hn
        }else {
           return true // bhut pese  han
        }
      
        
    }
    
}
