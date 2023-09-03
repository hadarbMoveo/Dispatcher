//
//  SignUpScreenViewodel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 31/08/2023.
//

import Foundation

class SignUpPageViewModel: ObservableObject, AuthViewModelProtocol {

    @Published var isSecure: [String: Bool] = [
        Strings.passwordPlaceholder: true,
        Strings.reEnterPasswordPlaceholder: true
    ]
    
    @Published var fields: [String: String] = [
        Strings.emailPlaceholder: "",
        Strings.passwordPlaceholder: "",
        Strings.reEnterPasswordPlaceholder: ""
    ]
    
    @Published var isError = false
    
    let inputPlaceholders = [Strings.emailPlaceholder,Strings.passwordPlaceholder,Strings.reEnterPasswordPlaceholder]
    var titleButton1:String = Strings.signUpButton
    var titleButton2:String = Strings.logInButton

    let title = Strings.titleSignupScreen
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func setValue(key: String, value: String) {
        fields[key] = value
    }
    
    func authentication() async -> Bool {
        if(isValid()) {
            if let email = fields[Strings.emailPlaceholder], let password = fields[Strings.passwordPlaceholder] {
                do{
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
        let email = fields[Strings.emailPlaceholder]
        let password = fields[Strings.passwordPlaceholder]
        let repassword = fields[Strings.reEnterPasswordPlaceholder]
        
        return (isValidEmail(email) && isValidPassword(password) && isVaidRePassword(password,repassword))
    }
    
    func changeSecureByField(field: String) {
        isSecure[field]?.toggle()
    }
    
}

