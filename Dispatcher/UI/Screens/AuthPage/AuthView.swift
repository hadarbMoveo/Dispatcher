//
//  AuthView.swift
//  Dispatcher
//
//  Created by Hadar Basson on 29/08/2023.
//

import SwiftUI

struct AuthView: View {
    

    
    var body: some View {
        GeometryReader { geo in
            
            let width = geo.size.width
            let height = geo.size.height
            
            VStack (spacing: 0) {
            
                topView().frame(width: width,height:height*0.35).background(Color("Primary"))
                bottomView().background(Color("auth-color"))
            }.frame(width: width, height: height)
        }
        
        
    }
}

@ViewBuilder
private func topView()-> some View {
    GeometryReader { geo in
        
        Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: geo.size.width*0.45).position(x: geo.size.width*0.5,y: geo.size.height*0.5)
    }
}

@ViewBuilder
private func bottomView()-> some View {
    let inputPlaceholders = ["Email", "Password","Re-Enter-Password"]
    GeometryReader { geo in
        VStack {
            Text("Singup").frame(maxWidth: .infinity, alignment: .leading).bold().font(.title2).padding(.top,30).padding(.leading,20).foregroundColor(Color("auth"))
            ForEach(0..<inputPlaceholders.count, id: \.self) { index in
                TextField(inputPlaceholders[index], text: .constant("")).frame(width: geo.size.width*0.83, height: 50)
                    .padding(.horizontal).background(.white)
                    .padding(.bottom,8)
            }
            
            Rectangle()
                .fill(Color("line-auth-page"))
                .frame(width: geo.size.width*0.9, height: 1).padding(.top,geo.size.height*0.1)
                .padding(.bottom,geo.size.height*0.06)
            
            Button(action: {

            }) {
                Text("SIGNUP")
                    .frame(width: geo.size.width*0.8,height: 5)
                    .foregroundColor(.white)
                    .padding()
                    .font(.custom("signup", size: 12))
                    .background(Color("button1-auth-page"))
                    .cornerRadius(10)
                    .padding(.top,30)
            }
            
            Button(action: {
                // Your button action here
            }) {
                Text("LOGIN")
                    .frame(width: geo.size.width*0.8,height: 5)
                    .foregroundColor(Color("auth"))
                    .padding()
                    .font(.custom("login", size: 12))
                    .background(Color("button2-auth-page"))
                    .cornerRadius(10)
                    .padding(.top)
            }
        }

    }
}

func act(){
    print("hadar")
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
