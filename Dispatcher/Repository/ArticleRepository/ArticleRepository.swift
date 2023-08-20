//
//  ArticleRepository.swift
//  Dispatcher
//
//  Created by Hadar Basson on 20/08/2023.
//

import Foundation
class ArticleRepository: ArticleRepositoryProtocol  {    
    let manager : NetworkManager = NetworkManager()
    
    func getArticles(completion: @escaping ([Card]) -> Void) {
        manager.fetchNews { articles in
            completion(articles)
        }
    }
}
