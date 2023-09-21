//
//  AuthRepository.swift
//  Dispatcher
//
//  Created by Hadar Basson on 20/09/2023.
//

import Foundation


class AuthRepository: AuthRepositoryProtocol {
    
    let manager: NetworkManager = NetworkManager()
    
    func register(email: String, password: String) async throws {
        do {
            let userData: [String:String] = ["email": email, "password": password ]
            let url = "/auth/register"
            let res = try await manager.request(url: url, method: "post", type: authResponse.self,params: userData)
            let token = res.token
            print(token)
            saveUserData(email: email, password: password,token:token)
        } catch {
            throw error
        }
    }
    
    func login(email: String, password: String) async throws {
        do {
            let userData: [String:String] = ["email": email, "password": password ]
            let url = "/auth/login"
            let res = try await manager.request(url: url, method: "post", type: authResponse.self,params: userData)
            let token = res.token
            saveUserData(email: email, password: password,token: token)
        } catch {
            throw error
        }
    }
    
    func logout() async throws {
        do {
//            try Auth.auth().signOut()
            RemoveUserData()
        } catch {
            throw error
        }
    }
    
    func saveUserData(email: String, password: String,token: String) {
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(password, forKey: "password")
        defaults.set(token, forKey: "token")
    }
    
    func RemoveUserData() {
        let defaults = UserDefaults.standard
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.synchronize()
    }
}
