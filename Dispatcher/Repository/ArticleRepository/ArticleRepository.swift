//
//  ArticleRepository.swift
//  Dispatcher
//
//  Created by Hadar Basson on 20/08/2023.
//

import Foundation

class ArticleRepository: ArticleRepositoryProtocol {
    let manager: NetworkManager = NetworkManager()
    
    func getArticles(completion: @escaping ([Card]) -> Void) {
        let apiKey = "ef5133dd364c41719494a74ce614d679"
        let articlesNumber = 7
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)&pageSize=\(articlesNumber)"
        
        manager.request(url: urlString,method: "get") { (newsResponse: NewsResponse) in
            completion(newsResponse.articles)
        }
    }
}

