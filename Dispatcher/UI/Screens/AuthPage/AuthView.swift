//
//  AuthView.swift
//  Dispatcher
//
//  Created by Hadar Basson on 29/08/2023.
//

import SwiftUI

struct AuthView: View {
    
    var viewModel: AuthViewModelProtocol
    var switchViewController: (() -> Void)
    var moveToTabBar : (() -> Void)
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            VStack (spacing: 0) {
                topView().frame(width: width,height:height*0.35).background(Color(Strings.topViewColorAuth))
                middleView(viewModel: viewModel).background(Color(Strings.middleViewColorAuth)).frame(width: width,height: height*0.40)
                bottomView(viewModel: viewModel, action: switchViewController,navigateToTabBarController:moveToTabBar)
                    .background(Color(Strings.middleViewColorAuth))
            }.frame(width: width, height: height)
            
        }
    }
}

@ViewBuilder
private func topView()-> some View {
    GeometryReader { geo in
        Image(Strings.imageLogo)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: geo.size.width*0.45).position(x: geo.size.width*0.5,y: geo.size.height*0.5)
    }
}

@ViewBuilder
private func middleView(viewModel: AuthViewModelProtocol)-> some View {
    
    GeometryReader { geo in
        VStack {
            Text(viewModel.title).frame(maxWidth: .infinity, alignment: .leading)
                .bold()
                .font(.title2)
                .padding(.top,30)
                .padding(.leading,20)
                .foregroundColor(Color(Strings.titleColorAuthView))
            ForEach(viewModel.inputPlaceholders.indices, id: \.self) { index in
                let field = viewModel.inputPlaceholders[index]
                let binding = Binding(
                    get: { viewModel.fields[field] ?? "" },
                    set: { newValue in viewModel.setValue(key: field, value: newValue) }
                )
                
                if ((field == Strings.passwordPlaceholder) || (field == Strings.reEnterPasswordPlaceholder)) {
                    HStack {
                        SecureField(viewModel.inputPlaceholders[index], text: binding)
                        Button(action: { viewModel.changeSecureByField(field: viewModel.inputPlaceholders[index])}) {
                            Image(Strings.inputColorAuthView)
                                .resizable()
                                .frame(width: 30, height: 25)
                        }
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
        }
        
    }
}


@ViewBuilder
private func bottomView(viewModel: AuthViewModelProtocol,action:@escaping (() -> Void),navigateToTabBarController:@escaping(()->Void)) -> some View{
    GeometryReader { geo in
        VStack {
            Rectangle()
                .fill(Color(Strings.lineColorAuthView))
                .frame(width: geo.size.width*0.9, height: 1).padding(.top,geo.size.height*0.1)
                .padding(.bottom,geo.size.height*0.06)
            
            Button(action: {
                viewModel.authentication(doWhenFinish:navigateToTabBarController)
            }) {
                HStack {
                    Text(viewModel.buttonText[0])
                    Image(Strings.rightArrowIconAuthView)
                }
                .frame(width: geo.size.width*0.8,height: 5)
                .foregroundColor(.white)
                .padding()
                .font(.custom(Strings.button1Font, size: 12))
                .background(Color(Strings.button1ColorAuthView))
                .cornerRadius(10)
                .padding(.top,30)
            }
            
            Button(action: action) {
                Text(viewModel.buttonText[1])
                    .frame(width: geo.size.width*0.8,height: 5)
                    .foregroundColor(Color(Strings.titleColorAuthView))
                    .padding()
                    .font(.custom(Strings.button2Font, size: 12))
                    .background(Color(Strings.button2ColorAuthView))
                    .cornerRadius(10)
                    .padding(.top)
            }
        }.padding(.leading,20)
    }
}


struct AuthView_Previews: PreviewProvider {
    
    static var previews: some View {
        AuthView(viewModel: LoginPageViewModel(authRepository: AuthFireBaseRepository()), switchViewController: {
            print("switchToSignUp")}, moveToTabBar: {
                print("moveToTabBar")
            })
    }
}


