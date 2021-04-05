//
//  ContentView.swift
//  FitFriends
//
//  Created by Matthew O'Meara on 3/16/21.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    var body: some View {
        ZStack{
            //assign color gradient to background
            LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color2"),Color("Color3")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            //fill up display if height > 800
            if UIScreen.main.bounds.height > 800 {
                mainPage()
            }
            else {
                //create a scroll view of display
                ScrollView(.vertical, showsIndicators: false){
                    mainPage()
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct mainPage : View {
    //variable to hold state of existing or new
    @State var index = 0;
    
    var body :some View{
        VStack {
            //FitFriends logo
            Image("Logo")
                .resizable()
                .frame(width: 200, height:180)
            
            //horizontal stack holding and new buttons
            HStack{
                
                //existing button
                Button(action: {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)){
                    self.index = 0
                    }

                }) {
                    Text("Existing")
                        .foregroundColor(self.index == 0 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .frame(width: (UIScreen.main.bounds.width - 50)/2)
                    
                }.background(self.index == 0 ? Color.white: Color.clear)
                .clipShape(Capsule())
                
                //new button
                Button(action: {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)){
                    self.index = 1
                    }
                    
                }) {
                    Text("New")
                        .foregroundColor(self.index == 1 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .frame(width: (UIScreen.main.bounds.width - 50)/2)
                    
                }.background(self.index == 1 ? Color.white: Color.clear)
                .clipShape(Capsule())
            }
            .background(Color.black.opacity(0.1))
            .clipShape(Capsule())
            .padding(.top, 25)
            
            //if index == 0 then the login page is currently viewed, therefore display forgot password button. Else if index == 1 then the register page is currently viewed, therefore forgot password button isn't needed.
            if self.index == 0{
                Login()
                Button(action: {
                }) {
                    Text("Forgot Password?")
                        .foregroundColor(.white)
                }
                .padding(.top,20)
            } else {
                SignUp()
            }
        }
        .padding()
    }
}

struct Login : View {
    
    //variables to hold email and password
    @State var user = ""
    @State var pass = ""
    @State var visible = false
    @State var loading = false
    
    var body : some View{
        VStack{
            //vertical stack holding all inputs
            VStack{
                //horizontal stack holding email address
                HStack(spacing: 15){
                    Image(systemName: "person")
                        .resizable()
                        .frame(width:16, height: 13)
                        .foregroundColor(.black)
                    TextField("Email Address or Username", text: self.$user)
                }.padding(.vertical, 20)
                
                Divider()
                
                //horizontal stack holding password
                HStack(spacing: 15){
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width:15, height:18)
                        .foregroundColor(.black)
                    if self.visible{
                        TextField("Password", text: self.$pass)
                    } else {
                        SecureField("Password", text: self.$pass)
                    }
            
                    Button(action: {
                        self.visible.toggle()
                    }) {
                        Image(systemName: self.visible ? "eye" : "eye.slash")
                            .foregroundColor(.black)
                    }
                }.padding(.vertical, 20)
                
                Divider()
            }
            //add padding around vertical stack holding email and password
            .padding(.vertical)
            .padding(.horizontal,20)
            .padding(.bottom,40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top,25)
            
            //button for login
            Button(action: {
                if user != "" && pass != "" {
                    if(!isValidUserName(user)){
                        print("is not a valid username")
                    }
                    withAnimation{
                        loading.toggle()
                    }
                } else {
                    
                }
            }){
                Text("LOGIN")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
            }.background(Color.init("Color"))
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom,-40)
            .shadow(radius: 25)
            
            if loading {
                //LoadView(placeHolder: "Logging In", show: $loading)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SignUp: View {
    
    //variables to hold email,pass,retype
    @State var user = ""
    @State var email = ""
    @State var pass = ""
    @State var retypePass = ""
    @State var visible1 = false;
    @State var visible2 = false;
    @State var alert = false
    @State var error = ""
    
    var body : some View{
        ZStack{
            VStack{
                VStack{
                //horizontal stack for email address box
                HStack(spacing: 15){
                    Image(systemName: "person")
                        .resizable()
                        .frame(width:16, height:13)
                        .foregroundColor(.black)
                    TextField("Enter Username", text: self.$user)
                }.padding(.vertical, 10)
                
                Divider()
                //horizontal stack for email address box
                HStack(spacing: 15){
                    Image(systemName: "envelope")
                        .resizable()
                        .frame(width:16, height:13)
                        .foregroundColor(.black)
                    TextField("Enter Email Address", text: self.$email)
                }.padding(.vertical, 10)
                
                Divider()
                
                //horizontal stack for password box
                HStack(spacing: 15){
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width:15, height:18)
                        .foregroundColor(.black)
                    if self.visible1{
                        TextField("Password", text: self.$pass)
                    } else {
                        SecureField("Password", text: self.$pass)
                    }
                    Button(action: {
                        self.visible1.toggle()
                    }) {
                        Image(systemName: self.visible1 ? "eye" : "eye.slash")
                            .foregroundColor(.black)
                    }
                }.padding(.vertical, 10)
                
                Divider()
                
                //horizontal stack for re-enter password box
                HStack(spacing: 15){
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width:15, height:18)
                        .foregroundColor(.black)
                    if self.visible2{
                        TextField("Re-Enter Password", text: self.$retypePass)
                    } else {
                        SecureField("Re-Enter Password", text: self.$retypePass)
                    }
                    Button(action: {
                        self.visible2.toggle()
                    }) {
                        Image(systemName: self.visible2 ? "eye" : "eye.slash")
                            .foregroundColor(.black)
                    }
                }.padding(.vertical, 10)
                
                Divider()
            }
            //add padding vertical stack holding email,pass,re-enter
            .padding(.vertical)
            .padding(.horizontal,20)
            .padding(.bottom,40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top,25)
            
            //button for signup
            Button(action: {
                checkInputs()
            }){
                Text("SIGNUP")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
            }.background(Color.init("Color"))
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom,-40)
            .shadow(radius: 25)
            }
            if self.alert{
                //ViewError(alert: self.$alert, error: self.$error)
            }
        }
    }
    func checkInputs(){
        if self.user != "" && self.email != "" &&  self.pass != "" && self.retypePass != "" {
            if(!isValidUserName(self.user)){
                print("Not valid username")
            } else if (!isValidEmail(self.email)){
                print("Not valid email")
            } else if (isValidPassword(self.pass)==0){
                print("valid password")
            } else if (isValidPassword(self.pass)==1){
                print("Not a valid length for password")
            } else if(isValidPassword(self.pass)==2){
                print("password must contain blabla")
            }
        } else {
            self.error = "Please fill in all blanks in order to register."
            self.alert.toggle()
        }
    }
}

//struct ViewError : View {
//    @State var color = Color.black.opacity(0.75)
//    @Binding var alert : Bool
//    @Binding var error : String
//
//    var body: some View {
//        GeometryReader{_ in
//            VStack {
//                HStack{
//                    Text("Error")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(self.color)
//
//                    Spacer()
//                }
//                .padding(.horizontal, 25)
//
//                Text(self.error)
//                    .foregroundColor(self.color)
//                    .padding(.top)
//                    .padding(.horizontal,25)
//                Button(action: {
//                    self.alert.toggle()
//                }) {
//                    Text("Cancel")
//                        .foregroundColor(.white)
//                        .padding(.vertical)
//                        .frame(width: UIScreen.main.bounds.width - 120)
//                }
//                .background(Color("Color"))
//                .cornerRadius(10)
//                .padding(.top, 25)
//
//            }
//            .padding(.vertical,25)
//            .frame(width: UIScreen.main.bounds.width - 30)
//            .background(Color.white)
//            .cornerRadius(15)
//
//        }
//        //.frame(width: 100, height: 100)
//        .background(Color.black.opacity(0.20).edgesIgnoringSafeArea(.all))
//    }
//}

//struct LoadView : View {
//    var placeHolder : String
//    @Binding var show : Bool
//    @State var animate = false
//    var body : some View {
//
//        VStack(spacing: 28) {
//            Circle()
//                .stroke(AngularGradient(gradient: .init(colors:[Color.primary,Color.primary.opacity(0)]), center: .center))
//                .frame(width: 80, height: 80)
//                .rotationEffect(.init(degrees: animate ? 360 : 0))
//            Text(placeHolder)
//                .fontWeight(.bold)
//
//        }
//        .padding(.vertical,25)
//        .padding(.horizontal,35)
//        .background(BlurView())
//        .cornerRadius(20)
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(
//            Color.primary.opacity(0.35).onTapGesture {
//                withAnimation{
//                    show.toggle()
//                }
//            }
//        )
//        .onAppear{
//            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)){
//                animate.toggle()
//            }
//
//        }
//    }
//}

//struct BlurView: UIViewRepresentable {
//    func makeUIView(context: Context) -> UIVisualEffectView {
//        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
//        return view
//    }
//
//    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
//
//    }
//}
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
//if ( isValidEmail(userEmailInput) && isValidPassword(passWordInput) == 0)
//{
//    print("Valid Email & Password will now attempt to 'login'")
//
//    //sets the value in param
//    params["email"] = userEmailInput
//    params["password"] = passWordInput
//
//    //Requests at (fitfriends, POST, data to go in, JSON format)
//    AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default) .responseJSON
//    { response in
//        //Loads into switch
//        switch response.result {
//        //If succesfully reaches site
//        case .success(_):
//
//            //shortens to data
//            if let data = response.data
//            {
//                //shortens to json
//                if let json = try? JSON(data: data)
//                {
//                    //On success prints corresponding values
//                    if (response.response?.statusCode == 201)
//                    {
//                        //If it reaches this point the user is succesfully logged in
//                        //You probably won't need this but its usefull to see if everything is working as it prints in the console
//                        print(json["message"])
//                        print(json["data"]["name"])
//                        print(json["data"]["email"])
//                        print(json["data"]["password"])
//                        //IMPORTANT identifies user for later use
//                        token = json["token"].rawString() ?? ""
//
//                        //You can send them to the user page at this point
//                    }
//                    else
//                    {
//                        //prints string attached to message such as no user found
//                        print(json["error"])
//                    }
//                }
//            }
//            break
//        case .failure(_):
//            print("INVALID URL")
//            break
//        }
//    }
//}
//else if (!isValidEmail(userEmailInput))
//{
//    print("Invalid Email")
//}
//else if (isValidPassword(passWordInput) == 1)
//{
//    print("Password must be 6 to 21 inches long")
//}
//else if (isValidPassword(passWordInput) == 2)
//{
//    print("Password must include a atleast 1 uppercase letter, lowercase letter, and a number")
//}
//
////-------------------------------------------------------------------------------
////Signup Request
////Only runs if the entered name, email, and password are valid
//if (isValidUserName(userNameInput) && isValidEmail(userEmailInput) && isValidPassword(passWordInput) == 0)
//{
//    print("Valid Email & Password will now attempt to 'signup'")
//    //sets the value in param
//    params2["name"] = userNameInput
//    params2["email"] = userEmailInput
//    params2["password"] = passWordInput
//
//    //Requests at (fitfriends, POST, data to go in, JSON format)
//    AF.request(url2, method: .post, parameters: params2, encoding: JSONEncoding.default) .responseJSON
//    { response in
//        //Loads into switch
//        switch response.result {
//        //If succesfully reaches site
//        case .success(_):
//
//            //shortens to data
//            if let data = response.data
//            {
//                //shortens to json
//                if let json = try? JSON(data: data)
//                {
//                    //On success prints corresponding values
//                    if (response.response?.statusCode == 201)
//                    {
//                        //If it reaches this, the user is succesfully signed up
//                        //You probably won't need this but its usefull to see if everything is working as it prints in the console
//                        print(json["message"])
//                        print(json["data"]["username"])
//                        print(json["data"]["email"])
//                        print(json["data"]["password"])
//                        //IMPORTANT we need this for later
//                        token = json["token"].rawString() ?? ""
//
//                        //They should be signed up and sent to login at this point
//                    }
//                    else
//                    {
//                        //prints string attached to message such as user already exists
//                        print(json["error"]["detail"])
//                    }
//                }
//            }
//            break
//        case .failure(_):
//            print("INVALID URL")
//            break
//        }
//    }
//}
//else if (isValidUserName(userNameInput))
//{
//    print("Username must be shorter than 21 characters")
//}
//else if (!isValidEmail(userEmailInput))
//{
//    print("Invalid Email")
//}
//else if (isValidPassword(passWordInput) == 1)
//{
//    print("Password must be 6 to 21 inches long")
//}
//else if (isValidPassword(passWordInput) == 2)
//{
//    print("Password must include a atleast 1 uppercase letter, lowercase letter, and a number")
//}
