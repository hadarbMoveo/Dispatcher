//
//  AuthView.swift
//  Dispatcher
//
//  Created by Hadar Basson on 29/08/2023.
//

import SwiftUI

struct AuthView: View {

    var viewModel: AuthViewModelProtocol
    var loginButtonTapped: (() -> Void)
    
    private func navigateToOtherViewController() {
        loginButtonTapped()
    }
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            VStack (spacing: 0) {
                
                topView().frame(width: width,height:height*0.35).background(Color("Primary"))
                bottomView(viewModel: viewModel, action: navigateToOtherViewController).background(Color("auth-color"))
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
private func bottomView(viewModel: AuthViewModelProtocol,action:@escaping (() -> Void))-> some View {
    
    GeometryReader { geo in
        VStack {
            Text(viewModel.title).frame(maxWidth: .infinity, alignment: .leading)
                .bold()
                .font(.title2)
                .padding(.top,30)
                .padding(.leading,20)
                .foregroundColor(Color("auth"))
            ForEach(viewModel.inputPlaceholders.indices, id: \.self) { index in
                let key = viewModel.inputPlaceholders[index]
                @State var input: String = ""
                let binding = Binding(
                    get: { viewModel.fields[key] ?? "" },
                    set: { newValue in viewModel.setValue(key: key, value: newValue) }
                )
                
                if key == "Password" || key == "Re-Enter-Password" {
                    HStack {
                        SecureField(viewModel.inputPlaceholders[index], text: binding)
                        Image("input-field-password").padding(.trailing, 10)
                    }
                    .frame(width: geo.size.width * 0.83, height: 50)
                    .padding(.horizontal)
                    .background(Color.white)
                    .padding(.bottom, 8)
                } else {
                    TextField(viewModel.inputPlaceholders[index], text: binding)
                        .frame(width: geo.size.width * 0.83, height: 50)
                        .padding(.horizontal)
                        .background(Color.white)
                        .padding(.bottom, 8)
                }
            }

            
            Rectangle()
                .fill(Color("line-auth-page"))
                .frame(width: geo.size.width*0.9, height: 1).padding(.top,geo.size.height*0.1)
                .padding(.bottom,geo.size.height*0.06)

            Button(action: {
                viewModel.register()
            }) {
                HStack {
                    Text(viewModel.buttonText[0])
                    Image("right-arrow")
                }
                .frame(width: geo.size.width*0.8,height: 5)
                .foregroundColor(.white)
                .padding()
                .font(.custom("signup", size: 12))
                .background(Color("button1-auth-page"))
                .cornerRadius(10)
                .padding(.top,30)
            }
            
            Button(action: action) {
                Text(viewModel.buttonText[1])
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


//struct AuthView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthView(viewModel: SignUpPageViewModel(authRepository: AuthFireBaseRepository(),))
//    }
//}


