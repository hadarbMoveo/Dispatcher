//
//  SignUpScreenViewodel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 31/08/2023.
//

import Foundation

class SignUpPageViewModel: ObservableObject, AuthViewModelProtocol {

    @Published var isSecure: [String: Bool] = [
        Strings.password: true,
        Strings.rePassword: true
    ]
    
    @Published var inputs: [String: String] = [
        Strings.email: "",
        Strings.password: "",
        Strings.rePassword: ""
    ]
    
    @Published var isError = false
    
    let inputPlaceholders = [Strings.email,Strings.password,Strings.rePassword]
    
    var titleButton1:String = Strings.signUpButton
    var titleButton2:String = Strings.logInButton

    let title = Strings.titleSignupScreen
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func setValueToInput(key: String, value: String) {
        inputs[key] = value
    }
    
    func authentication() async -> Bool {
        if(isValid()) {
            if let email = inputs[Strings.email], let password = inputs[Strings.password] {
                do {
                    try await authRepository.register(email: email, password:password)
                    return true
                }
                catch {
                    isError = true
                }
            }
        }
        
        isError = true
        return false
    }
    
    func isValid() -> Bool {
        let email = inputs[Strings.email]
        let password = inputs[Strings.password]
        let repassword = inputs[Strings.rePassword]
        
        return (isValidEmail(email) && isValidPassword(password) && isVaidRePassword(password,repassword))
    }
    
    func changeSecureByField(field: String) {
        isSecure[field]?.toggle()
    }
    
}

