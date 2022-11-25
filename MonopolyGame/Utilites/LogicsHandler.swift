 
class LogicsHandler {
    
    static let shared = LogicsHandler()


    func haveMoneyToBuy(player:Player,spndingAmount:Int)->Bool {
        
        var tempMoney = player.totalMoney
        tempMoney = tempMoney - spndingAmount
       
        print(tempMoney)
        
        print(player.totalMoney)
        
        
        if(tempMoney < 0) {
            return false // pese nhi bache
        }else {
           return true // bhut pese  han
        }
    }
    
    func haveAssets(player:Player)->Bool {
        
        let assetCount = player.assets.getAllAssetsTypes().count
        if(assetCount == 0) {
            return false // assets nhi hn
        }else {
           return true // assets pese  han
        }
    }
    
    func haveEnoughAssets(player:Player,spndingAmount:Int)->Bool {
        
        let totalValue = player.assets.getTotalValueOfAllAssets()
        let totalMoneyWithAssets = totalValue + player.totalMoney
        print("Total Value is ->>>>>> \(totalMoneyWithAssets)")
        if(spndingAmount > totalMoneyWithAssets) { // bank Corrept
            return false // assets value less then  nhi hn
        }else {
           return true
        }
    }
    
    
}
