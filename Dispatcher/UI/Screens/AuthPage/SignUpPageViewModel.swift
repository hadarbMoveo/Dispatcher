//
//  SignUpScreenViewodel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 31/08/2023.
//

import Foundation

class SignUpPageViewModel: ObservableObject, AuthViewModelProtocol {

    
    @Published var fields: [String: String] = [
        "Email": "",
        "Password": "",
        "Re-Enter-Password": ""
    ]

    let inputPlaceholders = ["Email", "Password","Re-Enter-Password"]
    
    let buttonText = ["SIGNUP", "LOGIN"]
    let title = "Signup"
    
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
    
    func buttonTapped() {
        register()
    }
    
}

