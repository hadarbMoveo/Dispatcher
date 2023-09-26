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
            let res = try await manager.request(url: url, method: "post", type: AuthResponse.self,params: userData)
            if(res.status == "success") {
                let token = res.token
                saveUserData(email: email, password: password,token:token)
            }
            else {
                throw MyError(message: res.message)
            }

        } catch {
            throw error
        }
    }
    
    func login(email: String, password: String) async throws {
        do {
            let userData: [String:String] = ["email": email, "password": password ]
            let url = "/auth/login"
            let res = try await manager.request(url: url, method: "post", type: AuthResponse.self,params: userData)
            if(res.status == "success") {
                let token = res.token
                saveUserData(email: email, password: password,token: token)
            }
            else {
                throw MyError(message: res.message)
            }
        } catch {
            throw error
        }
    }
    
    func logout() async throws {
        do {
         let url = "/auth/logout"
         let res = try await manager.request(url: url, method: "post", type: LogoutResponse.self)
            if(res.message == "Logout successful") {
                RemoveUserData()
            }
            else {
                throw MyError(message: res.message)
            }
        }
    }
    
    func saveUserData(email: String, password: String,token: String) {
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(password, forKey: "password")
        defaults.set(token, forKey: "token")
        let currentDate = Date()
        defaults.set(currentDate, forKey: "date")
        defaults.synchronize()
    }
    
    func RemoveUserData() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "password")
        defaults.removeObject(forKey: "token")
        defaults.removeObject(forKey: "date")
        defaults.synchronize()
    }
}
