//
//  AuthPageViewModel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 30/08/2023.
//

import Foundation

class LoginPageViewModel: ObservableObject, AuthViewModelProtocol {
    
    @Published var isSecure: [String : Bool] = [Strings.password: true]
    
    @Published var inputs: [String: String] = [
        Strings.email: "",
        Strings.password: "",
    ]

    let inputPlaceholders = [Strings.email, Strings.password]
    
    var titleButton1:String = Strings.logInButton
    var titleButton2:String = Strings.signUpButton
    
    @Published var isError = false

    let title = Strings.titleLoginScreen

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
                    try await authRepository.login(email: email, password:password)
                    return true
                }
                catch {
                    isError = true
                }
            }
        }
        
        else {
            isError = true
        }
        return false
    }
    
    func isValid()->Bool {
        let email = inputs[Strings.email]
        let password = inputs[Strings.password]
        
        return (isValidEmail(email) && isValidPassword(password))
    }
    
    func changeSecureByField(field: String) {
        isSecure[field] = !(isSecure[field] ?? true)
    }
    
}
