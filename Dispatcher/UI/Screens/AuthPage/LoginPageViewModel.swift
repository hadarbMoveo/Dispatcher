//
//  AuthPageViewModel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 30/08/2023.
//

import Foundation

class LoginPageViewModel: ObservableObject, AuthViewModelProtocol {

    
    @Published var fields: [String: String] = [
        "Email": "",
        "Password": "",
        "Re-Enter-Password": ""
    ]

    let inputPlaceholders = ["Email", "Password","Re-Enter-Password"]
    
    let buttonText = ["LOGIN", "SIGNUP"]

    let title = "Login"

    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func register() {
        if(isValidEmail(fields["Email"]) && isValidPassword(fields["Password"]) && isVaidRePassword(fields["Password"],fields["Re-Enter-Password"]) ) {
            authRepository.register(email: fields["Email"]!, password: fields["Password"]!)
        }
        else {
            print("Invalid email")
        }
        
    }
    
    func setValue(key: String, value: String) {
        fields[key] = value
    }
}
