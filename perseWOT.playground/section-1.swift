import Cocoa

import XCPlayground
XCPSetExecutionShouldContinueIndefinitely()


func getJSON(urlToRequest: String) -> NSData{
    return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
}
func parseJSON(inputData: NSData) -> NSDictionary{
    var error: NSError?
    var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.AllowFragments, error: &error) as NSDictionary
    
    return boardsDictionary
}

let parseAccountID = (parseJSON(getJSON("https://api.worldoftanks.ru/wot/account/list/?application_id=c2f02a1fea169312db457a323fd41441&fields=account_id,nickname&type=exact&search=")))

//println(parseAccountID)




if let parse = parseAccountID as? [String: AnyObject] {
    
    var status = parse["status"] as String!
    println(parse)
    
    println(status)
    
    if status == "ok" {
    
    if let data = parse["data"] as? [AnyObject] {
        for start in data {
            var account_id = start["account_id"] as NSNumber // Идентификатор аккаунта игрока
            var nickname = start["nickname"] as? NSString //Имя игрока
            println(account_id)
            println(nickname!)
        }
    }
}

else
{
    let parseError = parseAccountID["error"] as NSDictionary
    
    var code = parseError["code"] as? Int
    var message = parseError["message"] as? NSString
    var value = parseError["value"] as? NSString
    var field = parseError["field"] as? NSString
 
}
}
