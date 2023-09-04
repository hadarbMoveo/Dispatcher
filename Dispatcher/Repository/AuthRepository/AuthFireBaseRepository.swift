//
//  AuthRepository.swift
//  Dispatcher
//
//  Created by Hadar Basson on 30/08/2023.
//

import Foundation
import FirebaseAuth

class AuthFireBaseRepository: AuthRepositoryProtocol {
    
    func register(email: String, password: String) async throws {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            saveUserData(email: email, password: password)
        } catch {
            throw error
        }
    }
    
    func login(email: String, password: String) async throws {
        do {
            let user = try await Auth.auth().signIn(withEmail: email, password: password)
            saveUserData(email: email, password: password)
        } catch {
            throw error
        }
    }
    
    func logout() async throws {
        do {
            try Auth.auth().signOut()
            CleanUserData()
        } catch {
            throw error
        }
    }
    
    func saveUserData(email: String, password: String) {
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(password, forKey: "password")
    }
    
    func CleanUserData() {
        let defaults = UserDefaults.standard
        defaults.set("", forKey: "email")
        defaults.set("", forKey: "password")
    }
}
