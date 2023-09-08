//
//  SignUpScreenViewodel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 31/08/2023.
//

import Foundation

class SignUpPageViewModel: ObservableObject, AuthViewModelProtocol {
    
    @Published var isError: [String: Bool] = [
        Strings.email: false,
        Strings.password: false,
        Strings.rePassword: false
    ]
    
    var errorMessages: [String: String] = [
        Strings.email: "invalid email",
        Strings.password: "invalid password",
        Strings.rePassword: "passwords dont match"
    ]

    @Published var isSecure: [String: Bool] = [
        Strings.password: true,
        Strings.rePassword: true
    ]
    
    @Published var inputs: [String: String] = [
        Strings.email: "",
        Strings.password: "",
        Strings.rePassword: ""
    ]

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
    
    @MainActor
    func authentication() async -> Bool {
        if(isValid()) {
            if let email = inputs[Strings.email], let password = inputs[Strings.password] {
                do {
                    try await authRepository.register(email: email, password:password)
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
        isError[Strings.rePassword] = false
    }
    
    func isValid() -> Bool {
        let email = inputs[Strings.email]
        let password = inputs[Strings.password]
        let repassword = inputs[Strings.rePassword]
        
        isError[Strings.email] = !isValidEmail(email)
        isError[Strings.password] = !isValidPassword(password)
        isError[Strings.rePassword] = !isVaidRePassword(password,repassword)
        
        return (isValidEmail(email) && isValidPassword(password) && isVaidRePassword(password,repassword))
    }
    
    func changeSecureByField(field: String) {
        isSecure[field]?.toggle()
    }
    
}

