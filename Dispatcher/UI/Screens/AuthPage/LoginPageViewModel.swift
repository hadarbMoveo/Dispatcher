//
//  AuthPageViewModel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 30/08/2023.
//

import Foundation
import SwiftUI

class LoginPageViewModel: ObservableObject, AuthViewModelProtocol {

    @Published var isError: [String: Bool] = [
        Strings.email: false,
        Strings.password: false,
    ]
    
    @Published var colorBorderInputes: [String: Color] = [
        Strings.email: Color.borderTextField,
        Strings.password: Color.borderTextField,
    ]
    
    @Published var colorTextInputes: [String: Color] = [
        Strings.email: Color.black,
        Strings.password: Color.black,
    ]
    
    @Published var isAlert: Bool = false
    @Published var alertMessage: String = ""
    
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
    
    func clearInputs() {
        inputs[Strings.email] = ""
        inputs[Strings.password] = ""
    }
    
    @MainActor
    func authentication() async -> Bool {
        if(isValid()) {
            if let email = inputs[Strings.email], let password = inputs[Strings.password] {
                do {
                    try await authRepository.login(email: email, password:password)
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
        colorBorderInputes[Strings.email] = Color.borderTextField
        colorBorderInputes[Strings.password] = Color.borderTextField
        colorTextInputes[Strings.email] = Color.black
        colorTextInputes[Strings.password] = Color.black
    }
    
    func isValid()->Bool {
        let email = inputs[Strings.email]
        let password = inputs[Strings.password]
        
        isError[Strings.email] = !isValidEmail(email)
        isError[Strings.password] = !isValidPassword(password)
        
        if(isError[Strings.email] == true) {
            colorBorderInputes[Strings.email] = Color.red
            colorTextInputes[Strings.email] = Color.red
        }
        
        if(isError[Strings.password] == true) {
            colorBorderInputes[Strings.password] = Color.red
            colorTextInputes[Strings.password] = Color.red
        }
        
        return (isValidEmail(email) && isValidPassword(password))
    }
    
    func changeSecureByField(field: String) {
        isSecure[field] = !(isSecure[field] ?? true)
    }
    
    func validWhileLoseFocuse(field: String) {
        let email = inputs[Strings.email]
        let password = inputs[Strings.password]
        
        if field == Strings.email {
        validPasswordWhileLoseFocuse(password: password)
        }
        else {
        validEmailWhileLoseFocuse(email: email)
        }
    }
    
    func validEmailWhileLoseFocuse(email: String?) {
        if email != "" {
            isError[Strings.email] = !isValidEmail(email)
            if(isError[Strings.email] == true) {
                colorBorderInputes[Strings.email] = Color.red
                colorTextInputes[Strings.email] = Color.red
            }
        }
    }
    
    func validPasswordWhileLoseFocuse(password: String?) {
        if password != "" {
            isError[Strings.password] = !isValidPassword(password)
            if(isError[Strings.password] == true) {
                colorBorderInputes[Strings.password] = Color.red
                colorTextInputes[Strings.password] = Color.red
            }
        }
    }
    
    
    
    
}
