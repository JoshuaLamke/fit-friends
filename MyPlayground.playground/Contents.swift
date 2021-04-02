import UIKit
import Alamofire
import Foundation
import SwiftyJSON

//URL with endpoint to sent to
var url = "https://fit-friends.herokuapp.com/api/user/login"
//Parameters to input
let params = ["email": "ex@gmail.com", "password": "ex"]
//placeholder to store a message if there is one
var error = ""

//Requests at (fitfriends, POST, data to go in, JSON format)
AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON
{ response in
    //Prints out JSON
    print(response.result)
    //Loads into switch
    switch response.result {
    
    //If succesfully reaches site
    case .success(_):
        
        print("worked")
        
        //shortens to data
        if let data = response.data
        {
            //shortens to json
            if let json = try? JSON(data: data)
            {
                //prints string attached to message
                print(json["message"])
            }
        }
        break
    case .failure(_):
        print("INVALID URL")
        break
    }
}

