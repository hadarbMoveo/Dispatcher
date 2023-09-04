//
//  FavoritePageViewModel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 04/09/2023.
//

import Foundation
class FavoritePageViewModel {

    let repository: FavoriteRepositoryProtocol
    
    init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
}
