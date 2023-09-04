//
//  UserPageViewModel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 04/09/2023.
//

import Foundation

class UserPageViewModel {
    
    let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func logout() async -> Bool {
        do {
            try await repository.logout()
            return true
        }
        catch {
            return false
        }

    }
}
