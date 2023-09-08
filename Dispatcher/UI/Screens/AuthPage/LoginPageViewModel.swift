//
//  AuthPageViewModel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 30/08/2023.
//

import Foundation

class LoginPageViewModel: ObservableObject, AuthViewModelProtocol {
    @Published var isError: [String: Bool] = [
        Strings.email: false,
        Strings.password: false,
    ]
    
    var errorMessages: [String: String] = [
        Strings.email: "invalid email",
        Strings.password: "invalid password",
    ]
    
    @Published var isSecure: [String : Bool] = [Strings.password: true]
    
    @Published var inputs: [String: String] = [
        Strings.email: "",
        Strings.password: "",
    ]
    
    let inputPlaceholders = [Strings.email, Strings.password]
    
    var titleButton1:String = Strings.logInButton
    var titleButton2:String = Strings.signUpButton
    
    let title = Strings.titleLoginScreen

    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func setValueToInput(key: String, value: String) {
        inputs[key] = value
    }
    
    @MainActor
    func authentication() async -> Bool {
        if(isValid()) {
            if let email = inputs[Strings.email], let password = inputs[Strings.password] {
                do {
                    try await authRepository.login(email: email, password:password)
                    return true
                }
                catch let error {
                    print(error)
                }
            }
        }
        
        return false
    }
    
    func clearErrors() {
        isError[Strings.email] = false
        isError[Strings.password] = false
    }
    
    func isValid()->Bool {
        let email = inputs[Strings.email]
        let password = inputs[Strings.password]
        
        isError[Strings.email] = !isValidEmail(email)
        isError[Strings.password] = !isValidPassword(password)
        
        return (isValidEmail(email) && isValidPassword(password))
    }
    
    func changeSecureByField(field: String) {
        isSecure[field] = !(isSecure[field] ?? true)
    }
    
}
