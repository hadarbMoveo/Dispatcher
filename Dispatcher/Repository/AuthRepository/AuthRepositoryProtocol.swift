//
//  AuthRepositoryProtocol.swift
//  Dispatcher
//
//  Created by Hadar Basson on 30/08/2023.
//

import Foundation

protocol AuthRepositoryProtocol {
    func register(email:String,password:String) async throws -> Void
    func login(email:String,password:String) async throws -> Void
    func logout() async throws -> Void
}

