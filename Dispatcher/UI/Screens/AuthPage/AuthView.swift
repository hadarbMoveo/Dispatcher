//
//  AuthView.swift
//  Dispatcher
//
//  Created by Hadar Basson on 29/08/2023.
//

import SwiftUI

struct AuthView<Model>: View where Model: AuthViewModelProtocol {
    
    @ObservedObject var viewModel: Model
    var switchViewController: (() -> Void)
    var ChangeAuthView : (() -> Void)
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            VStack (spacing: 0) {
                logoSectionView()
                    .frame(width: width,height:height*0.35)
                    .background(Color.topViewColorAuth)
                
                inputsSectionView()
                    .frame(width: width,height: height*0.40)
                    .background(Color.middleViewColorAuth)
                
                buttonsSectionView()
                    .background(Color.middleViewColorAuth)
            }
            .frame(width: width, height: height)
        }
    }
    
    @ViewBuilder
    private func logoSectionView()-> some View {
        GeometryReader { geo in
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geo.size.width*0.45)
                .position(x: geo.size.width*0.5, y: geo.size.height*0.5)
        }
    }
    
    
    @ViewBuilder
    private func inputsSectionView()-> some View {
        
        GeometryReader { geo in
            VStack {
                Text(viewModel.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                    .font(.title2)
                    .padding(.top,30)
                    .padding(.leading,20)
                    .foregroundColor(Color.titleColorAuthView)
                
                ForEach(viewModel.inputPlaceholders, id: \.self) { placeHolder in
                    let field =  placeHolder
                    let binding = Binding(
                        get: { viewModel.fields[field] ?? "" },
                        set: { newValue in viewModel.setValue(key: field, value: newValue) }
                    )
                    
                    SetCustomInputText(field: field, binding: binding, width: geo.size.width).padding(.bottom, 8)
                }
            }
            
        }
    }
    
    @ViewBuilder
    private func buttonsSectionView() -> some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            VStack {
                
                Rectangle()
                    .fill(Color.lineColorAuthView)
                    .frame(width: width*0.9, height: 1)
                    .padding(.top, height*0.1)
                    .padding(.bottom, height*0.06)
                
                Button(action: {
                    
                }) {
                    HStack {
                        Text(viewModel.titleButton1)
                        Image(Strings.rightArrowIconAuthView)
                    }
                    .frame(width: width*0.8,height: 5)
                    .foregroundColor(.white)
                    .padding()
                    .font(.custom(Strings.button1Font, size: 12))
                    .background(Color.button1ColorAuthView)
                    .cornerRadius(10)
                    .padding(.top,30)
                    
                }
                
                Button(action: switchViewController) {
                    Text(viewModel.titleButton2)
                        .frame(width: width*0.8,height: 5)
                        .foregroundColor(Color.titleColorAuthView)
                        .padding()
                        .font(.custom(Strings.button2Font, size: 12))
                        .background(Color.button2ColorAuthView)
                        .cornerRadius(10)
                        .padding(.top)
                }
            }
            .padding(.leading,20)
        }
    }
    
    @ViewBuilder
    private func SetCustomInputText(field: String, binding: Binding<String>,width: CGFloat) -> some View {
        if (field == Strings.passwordPlaceholder || field == Strings.reEnterPasswordPlaceholder) {
            if viewModel.isSecure[field] == true {
                HStack {
                    
                    SecureField(field, text: binding)
                    
                    Button(action: {
                        viewModel.changeSecureByField(field: field)
                    }) {
                        Image("input-field-password")
                            .resizable()
                            .frame(width: 30, height: 25)
                    }
                }   .frame(width: width * 0.83, height: 50)
                    .padding(.horizontal)
                    .background(Color.white)
                
            } else {
                HStack {
                    
                    TextField(field, text: binding)
                    
                    Button(action: {
                        viewModel.changeSecureByField(field: field)
                    }) {
                        Image("input-field-password")
                            .resizable()
                            .frame(width: 30, height: 25)
                    }
                }   .frame(width: width * 0.83, height: 50)
                    .padding(.horizontal)
                    .background(Color.white)
            }
        }
        else{
            
            TextField(field, text: binding)
                .frame(width: width * 0.83, height: 50)
                .padding(.horizontal)
                .background(Color.white)
        }
    }
}

extension Color {
    
    static let titleColorAuthView = Color("auth")
    static let inputColorAuthView = Color("input-field-password")
    static let topViewColorAuth = Color("Primary")
    static let middleViewColorAuth = Color("auth-color")
    static let lineColorAuthView = Color("line-auth-page")
    static let button1ColorAuthView = Color("button1-auth-page")
    static let button2ColorAuthView = Color("button2-auth-page")
}

#if DEBUG
struct AuthView_Previews: PreviewProvider {
    
    static var previews: some View {
        let repo = AuthFireBaseRepository()
        let vm = LoginPageViewModel(authRepository: repo)
        AuthView(viewModel: vm,
                 switchViewController: {
            print("switchToSignUp")},
                 ChangeAuthView: {
            print("moveToTabBar")}
        )
    }
}
#endif

