//
//  AuthPageViewModel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 30/08/2023.
//

import Foundation

class AuthPageViewModel: ObservableObject {
    
    @Published var email: String = "hadar1111"
    @Published var password: String = "hadar1111"
    @Published var reenterPassword: String = "hadar1111"

    let inputPlaceholders = ["Email", "Password","Re-Enter-Password"]

    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func register() {
        authRepository.register(email: email, password: password)
    }

}
