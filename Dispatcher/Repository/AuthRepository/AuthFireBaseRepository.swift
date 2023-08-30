//
//  AuthRepository.swift
//  Dispatcher
//
//  Created by Hadar Basson on 30/08/2023.
//

import Foundation
import FirebaseAuth

class AuthFireBaseRepository: AuthRepositoryProtocol {
    
    func register(email: String, password: String) {
        print(email)
        Auth.auth().createUser(withEmail: "hadar1111@gmail.com", password: password) { authResult, error in
            if let error = error {
                print("Registration failed: \(error)")
            } else {
                print("Registration successful!")
            }
        }
    }
    
    func login(email: String, password: String) {
        
    }
    
    func logout() {
        
    }
    
    
}
