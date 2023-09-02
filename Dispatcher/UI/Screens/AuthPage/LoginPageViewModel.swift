//
//  AuthPageViewModel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 30/08/2023.
//

import Foundation

class LoginPageViewModel: ObservableObject, AuthViewModelProtocol {

    
    @Published var fields: [String: String] = [
        Strings.emailPlaceholder: "",
        Strings.passwordPlaceholder: "",
    ]

    let inputPlaceholders = [Strings.emailPlaceholder, Strings.passwordPlaceholder]
    
    let buttonText = [Strings.logInButton, Strings.signUpButton]

    let title = Strings.titleLoginScreen
    

    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    
    func setValue(key: String, value: String) {
        fields[key] = value
    }
    
    func buttonTapped(action:(()->Void)) {
        if(isValid()) {
            authRepository.login(email: fields[Strings.emailPlaceholder]!, password: fields[Strings.passwordPlaceholder]!)
            action()
        }
        else {
            print("Invalid email")
        }
    }
    
    func isValid()->Bool{
        return (isValidEmail(fields[Strings.emailPlaceholder]) && isValidPassword(fields[Strings.passwordPlaceholder]))
    }
    
}
