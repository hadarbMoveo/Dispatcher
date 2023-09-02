//
//  SignUpScreenViewodel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 31/08/2023.
//

import Foundation

class SignUpPageViewModel: ObservableObject, AuthViewModelProtocol {

    
    @Published var fields: [String: String] = [
        Strings.emailPlaceholder: "",
        Strings.passwordPlaceholder: "",
        Strings.reEnterPasswordPlaceholder: ""
    ]

    let inputPlaceholders = [Strings.emailPlaceholder, Strings.passwordPlaceholder,Strings.reEnterPasswordPlaceholder]
    
    let buttonText = [Strings.signUpButton,Strings.logInButton]

    let title = Strings.titleSignupScreen
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func setValue(key: String, value: String) {
        fields[key] = value
    }
    
    func buttonTapped(action:(()->Void)) {
        if(isValid()) {
            authRepository.register(email: fields[Strings.emailPlaceholder]!, password: fields[Strings.passwordPlaceholder]!)
            action()
        }
        else {
            print("Invalid email")
        }
    }
    
    func isValid()->Bool{
        return (isValidEmail(fields[Strings.emailPlaceholder]) && isValidPassword(fields[Strings.passwordPlaceholder]) && isVaidRePassword(fields[Strings.passwordPlaceholder],fields[Strings.reEnterPasswordPlaceholder]) )
    }
    
}

