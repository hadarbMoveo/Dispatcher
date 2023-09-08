//
//  AuthView.swift
//  Dispatcher
//
//  Created by Hadar Basson on 29/08/2023.
//

import SwiftUI

struct AuthView<Model>: View where Model: AuthViewModelProtocol {
    
    @ObservedObject var viewModel: Model
    var changeAuthView: (() -> Void)
    var continueToHomePage: (() -> Void)
    
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
    private func logoSectionView() -> some View {
        GeometryReader { geo in
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geo.size.width*0.45)
                .position(x: geo.size.width*0.5, y: geo.size.height*0.5)
        }
    }
    
    
    @ViewBuilder
    private func inputsSectionView() -> some View {
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
                    let field = placeHolder
                    let binding = Binding(
                        get: { viewModel.inputs[field] ?? "" },
                        set: { newValue in viewModel.setValueToInput(key: field, value: newValue) }
                    )
                    
                    SetCustomInputText(field: field,
                                       binding: binding,
                                       width: geo.size.width)
                    .padding(.bottom, 4)
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
                    Task {
                        let isAuthenticated = try await viewModel.authentication()
                        if isAuthenticated {
                            continueToHomePage()
                        }
                    }
                }) {
                    HStack {
                        Text(viewModel.titleButton1)
                        Image("right-arrow")
                    }
                    .frame(width: width*0.8,height: 5)
                    .foregroundColor(.white)
                    .padding()
                    .font(.custom("font", size: 12))
                    .background(Color.button1ColorAuthView)
                    .cornerRadius(10)
                    .padding(.top,30)
                    
                }
                
                Button(action: changeAuthView) {
                    Text(viewModel.titleButton2)
                        .frame(width: width*0.8,height: 5)
                        .foregroundColor(Color.titleColorAuthView)
                        .padding()
                        .font(.custom("font", size: 12))
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

        ZStack {
            let isSecure = field == Strings.password || field == Strings.rePassword
            
            if isSecure {
                HStack {
                    
                    if viewModel.isSecure[field] == true {
                        SecureField(field, text: binding)
                            .onChange(of: viewModel.inputs[field]) { newValue in
                                viewModel.clearErrors()
                            }
                    } else {
                        TextField(field, text: binding)
                            .onChange(of: viewModel.inputs[field]) { newValue in
                                viewModel.clearErrors()
                            }
                    }
                    
                    Button(action: {
                        viewModel.changeSecureByField(field: field)
                    }) {
                        Image("input-field-password")
                            .resizable()
                            .frame(width: 30, height: 25)
                    }
                }
                .frame(width: width * 0.83, height: 48)
                .padding(.horizontal)
                .background(Color.white)
                    
            } else {
                
                TextField(field, text: binding)
                    .frame(width: width * 0.83, height: 48)
                    .padding(.horizontal)
                    .background(Color.white)
                    .onChange(of: viewModel.inputs[field]) { newValue in
                        viewModel.clearErrors()
                    }
                
            }

            
            let isFieldError = viewModel.isError[field] == true
            if isFieldError {
                let errorMsg = viewModel.errorMessages[field] ?? ""
                Text(isFieldError ? errorMsg : "")
                    .frame(width: width * 0.88, height: 2, alignment: .leading)
                    .foregroundColor(.red)
                    .padding(.top, 72)
            }
        }
        .frame(height: 66)

    }
}


#if DEBUG
struct AuthView_Previews: PreviewProvider {
    
    static var previews: some View {
        let repo = AuthFireBaseRepository()
        let vm = LoginPageViewModel(authRepository: repo)
        AuthView(viewModel: vm,
                 changeAuthView: {
            print("switchToSignUp")},
                 continueToHomePage: {
            print("moveToTabBar")}
        )
    }
}
#endif

