//
//  AuthPageViewModel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 30/08/2023.
//

import Foundation

class LoginPageViewModel: ObservableObject, AuthViewModelProtocol {
    @Published var isSecure: [String : Bool] = [Strings.passwordPlaceholder: true]
    
    @Published var fields: [String: String] = [
        Strings.emailPlaceholder: "",
        Strings.passwordPlaceholder: "",
    ]

    let inputPlaceholders = [Strings.emailPlaceholder, Strings.passwordPlaceholder]
    
    var titleButton1:String = Strings.logInButton
    var titleButton2:String = Strings.signUpButton
    
    @Published var isError = false

    let title = Strings.titleLoginScreen
    

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
                    try await authRepository.login(email: email, password:password)
                    return true
                }
                catch {
                    isError = true
                }
            }
        }
        
        else{
            isError = true
        }

        return false
    }
    
    func isValid()->Bool{
        let email = fields[Strings.emailPlaceholder]
        let password = fields[Strings.passwordPlaceholder]
        
        return (isValidEmail(email) && isValidPassword(password))
    }
    
    func changeSecureByField(field: String) {
        isSecure[field] = !(isSecure[field] ?? true)
    }
    
}
