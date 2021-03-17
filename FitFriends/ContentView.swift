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
                    self.index = 0
                    
                }) {
                    Text("Existing")
                        .foregroundColor(self.index == 0 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .frame(width: (UIScreen.main.bounds.width - 50)/2)
                    
                }.background(self.index == 0 ? Color.white: Color.clear)
                .clipShape(Capsule())
                
                Button(action: {
                    self.index = 1
                    
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
        }
    }
}
