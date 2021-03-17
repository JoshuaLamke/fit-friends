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
            LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color2"),Color("Color3")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
//            LinearGradient(gradient: .init(colors: [Color("Color4")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            loginPage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct loginPage : View {
    @State var index = 0;
    var body :some View{
        VStack {
            
            Image("Logo")
                .resizable()
                .frame(width: 200, height:180)
            
            HStack{
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
            }.background(Color.black.opacity(0.1))
            .clipShape(Capsule())
            .padding(.top, 25)
            
            if self.index == 0{
                Login()
            } else {
                SignUp()
            }
            
            Button(action: {
                
            }) {
                Text("Forgot Password")
                    .foregroundColor(.white)
            }
            .padding(.top,20)
            HStack(spacing: 15) {
                
                Color.white.opacity(0.7)
                    .frame(width: 35, height: 1)
                Text("Or")
                    .foregroundColor(.white)
                Color.white.opacity(0.7)
                    .frame(width: 35, height: 1)
            }
            .padding(.top,10)
        }
        .padding()
    }
}

struct Login : View {
    
    @State var mail = ""
    @State var pass = ""
    
    var body : some View{
        VStack{
            //vertical stack holding all inputs
            VStack{
                //email address horizontal stack
                HStack(spacing: 15){
                    Image(systemName: "envelope")
                        .resizable()
                        .frame(width:16, height: 13)
                        .foregroundColor(.black)
                    TextField("Email Address", text: self.$mail)
                }.padding(.vertical, 20)
                
                //divide email and pass
                Divider()
                
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
                //divide email and login
                Divider()
            }
            //add padding around username and password
            .padding(.vertical)
            .padding(.horizontal,20)
            .padding(.bottom,40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top,25)
            
            Button(action: {
                
            }){
                Text("LOGIN")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                
//            }.background (LinearGradient(gradient: .init(colors: [Color("Color2"),Color("Color1"),Color("Color")]), startPoint: .leading, endPoint: .trailing))
            }.background (LinearGradient(gradient: .init(colors: [Color("Color")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom,-40)
            .shadow(radius: 25)
        }
    }
}

struct SignUp: View {
    
    @State var mail = ""
    @State var pass = ""
    @State var retypePass = ""
    
    var body : some View{
        VStack{
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "envelope")
                        .resizable()
                        .frame(width:16, height:13)
                        .foregroundColor(.black)
                    
                    TextField("Enter Email Address", text: self.$mail)
                    
                }.padding(.vertical, 20)
                Divider()
                
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
            //add padding around username and password
            .padding(.vertical)
            .padding(.horizontal,20)
            .padding(.bottom,40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top,25)
            
            Button(action: {
                
            }){
                Text("SIGNUP")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                
//            }.background (LinearGradient(gradient: .init(colors: [Color("Color2"),Color("Color1"),Color("Color")]), startPoint: .leading, endPoint: .trailing))
            }.background (LinearGradient(gradient: .init(colors: [Color("Color")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom,-40)
            .shadow(radius: 25)
        }
    }
}
