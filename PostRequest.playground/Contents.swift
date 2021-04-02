import UIKit
import Alamofire
import Foundation
import SwiftyJSON

//URL with endpoint to sent to
var url = "https://fit-friends.herokuapp.com/api/user/login"
//Parameters to input
var params = ["email": "", "password": ""]

//URL with endpoint to sent to
var url2 = "https://fit-friends.herokuapp.com/api/user/signup"
//Parameters to input
var params2 = ["name": "", "email": "", "password": ""]


//Sample Values these will come from the text field
var userNameInput = "Tyler3"
var userEmailInput = "tyl3@gmail.com"
var passWordInput = "abcdefG1"

//boolean just to turn functions on and off for testing
var testPost = false

//---------------------------------------------------------------------------
//Check if username is in right format
func isValidUserName(_ name: String) -> Bool {
    if (name.count <= 21)
    {
        return true
    }
    return false
}

//Check if email is in right format
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

//Check if password is in right format
func isValidPassword(_ password: String) -> Int {
    
    //Password is of valid length
    if (password.count >= 6 && password.count < 21)
    {
        //Checks if there is a capital letter
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard texttest.evaluate(with: password) else
        {
            return 2
        }
        //Checks if there is a lowercase letter
        let lowerLetterRegEx  = ".*[a-z]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", lowerLetterRegEx)
        guard texttest2.evaluate(with: password) else
        {
            return 2
        }
        //Checks if there is a number
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        guard texttest1.evaluate(with: password) else
        {
            return 2
        }

        return 0
    }
    else
    {
        return 1
    }
}

//---------------------------------------------------------------------------

//Login Request
//Only runs if the entered email and password are valid
if ( isValidEmail(userEmailInput) && isValidPassword(passWordInput) == 0 && testPost == true)
{
    print("Valid Email & Password will now attempt to 'login'")
    
    //sets the value in param
    params["email"] = userEmailInput
    params["password"] = passWordInput
    
    //Requests at (fitfriends, POST, data to go in, JSON format)
    AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default) .responseJSON
    { response in
        //Loads into switch
        switch response.result {
        //If succesfully reaches site
        case .success(_):
        
            //shortens to data
            if let data = response.data
            {
                //shortens to json
                if let json = try? JSON(data: data)
                {
                    //On success prints corresponding values
                    if (response.response?.statusCode == 201)
                    {
                        print(json["message"])
                        print(json["data"]["name"])
                        print(json["data"]["email"])
                        print(json["data"]["password"])
                    }
                    else
                    {
                        //prints string attached to message
                        print(json["error"])
                    }
                }
            }
            break
        case .failure(_):
            print("INVALID URL")
            break
        }
    }
}
else if (!isValidEmail(userEmailInput))
{
    print("Invalid Email")
}
else if (isValidPassword(passWordInput) == 1)
{
    print("Password must be 6 to 21 inches long")
}
else if (isValidPassword(passWordInput) == 2)
{
    print("Password must include a atleast 1 uppercase letter, lowercase letter, and a number")
}

//-------------------------------------------------------------------------------

//Signup Request
//Only runs if the entered name, email, and password are valid
if (isValidUserName(userNameInput) && isValidEmail(userEmailInput) && isValidPassword(passWordInput) == 0)
{
    print("Valid Email & Password will now attempt to 'signup'")
    //sets the value in param
    params2["name"] = userNameInput
    params2["email"] = userEmailInput
    params2["password"] = passWordInput
    
    //Requests at (fitfriends, POST, data to go in, JSON format)
    AF.request(url2, method: .post, parameters: params2, encoding: JSONEncoding.default) .responseJSON
    { response in
        //Loads into switch
        switch response.result {
        //If succesfully reaches site
        case .success(_):
        
            //shortens to data
            if let data = response.data
            {
                //shortens to json
                if let json = try? JSON(data: data)
                {
                    //On success prints corresponding values
                    if (response.response?.statusCode == 201)
                    {
                        print(json["message"])
                        print(json["data"]["username"])
                        print(json["data"]["email"])
                        print(json["data"]["password"])
                    }
                    else
                    {
                        //prints string attached to message
                        print(json["error"]["detail"])
                    }
                }
            }
            break
        case .failure(_):
            print("INVALID URL")
            break
        }
    }
}
else if (isValidUserName(userNameInput))
{
    print("Username must be shorter than 21 characters")
}
else if (!isValidEmail(userEmailInput))
{
    print("Invalid Email")
}
else if (isValidPassword(passWordInput) == 1)
{
    print("Password must be 6 to 21 inches long")
}
else if (isValidPassword(passWordInput) == 2)
{
    print("Password must include a atleast 1 uppercase letter, lowercase letter, and a number")
}
