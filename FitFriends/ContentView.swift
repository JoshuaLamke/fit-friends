//
//  ContentView.swift
//  FitFriends
//
//  Created by Matthew O'Meara on 3/16/21.
//

import SwiftUI

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
    @State var email = ""
    @State var pass = ""
    
    var body : some View{
        VStack{
            //vertical stack holding all inputs
            VStack{
                //horizontal stack holding email address
                HStack(spacing: 15){
                    Image(systemName: "envelope")
                        .resizable()
                        .frame(width:16, height: 13)
                        .foregroundColor(.black)
                    TextField("Email Address", text: self.$email)
                }.padding(.vertical, 20)
                
                Divider()
                
                //horizontal stack holding password
                HStack(spacing: 15){
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width:15, height:18)
                        .foregroundColor(.black)
                    SecureField("Password", text: self.$pass)
            
                    Button(action: {
                    }) {
                        Image(systemName: "eye")
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
        }
    }
}

struct SignUp: View {
    
    //variables to hold email,pass,retype
    @State var email = ""
    @State var pass = ""
    @State var retypePass = ""
    
    var body : some View{
        
        VStack{
            VStack{
                //horizontal stack for email address box
                HStack(spacing: 15){
                    Image(systemName: "envelope")
                        .resizable()
                        .frame(width:16, height:13)
                        .foregroundColor(.black)
                    TextField("Enter Email Address", text: self.$email)
                }.padding(.vertical, 20)
                
                Divider()
                
                //horizontal stack for password box
                HStack(spacing: 15){
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width:15, height:18)
                        .foregroundColor(.black)
                    SecureField("Create Password", text: self.$pass)
                    Button(action: {
                    }) {
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    }
                }.padding(.vertical, 20)
                
                Divider()
                
                //horizontal stack for re-enter password box
                HStack(spacing: 15){
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width:15, height:18)
                        .foregroundColor(.black)
                    SecureField("Re-Enter Password", text: self.$retypePass)
                    Button(action: {
                    }) {
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    }
                }.padding(.vertical, 20)
                
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
    }
}
