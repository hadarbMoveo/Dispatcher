//
//  SignUpScreenViewodel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 31/08/2023.
//

import Foundation
import SwiftUI

class SignUpPageViewModel: ObservableObject, AuthViewModelProtocol {

    @Published var isError: [String: Bool] = [
        Strings.email: false,
        Strings.password: false,
        Strings.rePassword: false
    ]
    
    @Published var ColorBorderInputes: [String: Color] = [
        Strings.email: Color.borderTextField,
        Strings.password: Color.borderTextField,
        Strings.rePassword: Color.borderTextField,
    ]
    
    @Published var ColorTextInputes: [String: Color] = [
        Strings.email: Color.black,
        Strings.password: Color.black,
        Strings.rePassword: Color.black,
    ]

    var errorMessages: [String: String] = [
        Strings.email: "invalid email",
        Strings.password: "invalid password",
        Strings.rePassword: "passwords dont match"
    ]
    
    @Published var isAlert: Bool = false
    @Published var alertMessage: String = ""

    @Published var isSecure: [String: Bool] = [
        Strings.password: true,
        Strings.rePassword: true
    ]
    
    @Published var inputs: [String: String] = [
        Strings.email: "",
        Strings.password: "",
        Strings.rePassword: ""
    ]
    
    func clearInputs() {
        inputs[Strings.email] = ""
        inputs[Strings.password] = ""
        inputs[Strings.rePassword] = ""
    }

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
                catch {
                    if let customError = error as? MyError {
                        isAlert = true
                        alertMessage = customError.message
                    }
                }
            }
        }
        
        return false
    }
    
    func clearErrors() {
        isError[Strings.email] = false
        isError[Strings.password] = false
        isError[Strings.rePassword] = false
        ColorBorderInputes[Strings.email] = Color.borderTextField
        ColorBorderInputes[Strings.password] = Color.borderTextField
        ColorBorderInputes[Strings.rePassword] = Color.borderTextField
        ColorTextInputes[Strings.email] = Color.black
        ColorTextInputes[Strings.password] = Color.black
        ColorTextInputes[Strings.rePassword] = Color.black
    }
    
    func isValid() -> Bool {
        let email = inputs[Strings.email]
        let password = inputs[Strings.password]
        let repassword = inputs[Strings.rePassword]
        
        isError[Strings.email] = !isValidEmail(email)
        isError[Strings.password] = !isValidPassword(password)
        isError[Strings.rePassword] = !isVaidRePassword(password,repassword)
        
        if(isError[Strings.email] == true) {
            ColorBorderInputes[Strings.email] = Color.red
            ColorTextInputes[Strings.email] = Color.red
        }
        
        if(isError[Strings.password] == true) {
            ColorBorderInputes[Strings.password] = Color.red
            ColorTextInputes[Strings.password] = Color.red
        }
        
        if(isError[Strings.rePassword] == true) {
            ColorBorderInputes[Strings.rePassword] = Color.red
            ColorTextInputes[Strings.rePassword] = Color.red
        }
        
        return (isValidEmail(email) && isValidPassword(password) && isVaidRePassword(password,repassword))
    }
    
    func changeSecureByField(field: String) {
        isSecure[field]?.toggle()
    }
    
}

