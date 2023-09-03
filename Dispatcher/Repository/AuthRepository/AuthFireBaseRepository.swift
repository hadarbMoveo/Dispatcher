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
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Registration failed: \(error)")
            } else {
                self.saveUserData(email: email, password: password)
                print("Registration successful!")
                
            }
        }
    }
    
    func login(email: String, password: String) {
        
//        let t: AuthDataResult = Auth.auth().signIn(withEmail: email, password: password)

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            
            if let error = error {
                print("Sign-in error: \(error.localizedDescription)")
                return
            }
            
            if let user = authResult?.user {
                print("Successfully signed in as user: \(user.uid)")
            }
        }
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Successfully signed out")
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
        
    }
    
    
    func saveUserData(email: String, password: String) {
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(password, forKey: "password")
    }
}
