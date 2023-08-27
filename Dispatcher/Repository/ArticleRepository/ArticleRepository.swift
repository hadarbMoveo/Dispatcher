//
//  ArticleRepository.swift
//  Dispatcher
//
//  Created by Hadar Basson on 20/08/2023.
//

import Foundation

class ArticleRepository: ArticleRepositoryProtocol {

    let manager: NetworkManager = NetworkManager()
    let articlesNumber = 7
    
    func getArticles(completion: @escaping ([Card]) -> Void) {
        let url = "/top-headlines?country=us&apiKey=\(NetworkManager.apiKey)&pageSize=\(self.articlesNumber)"
        manager.request(url: url,method: "get") { (newsResponse: NewsResponse) in
            completion(newsResponse.articles)
        }
    }
    
    func getArticles() async throws -> [Card] {
        let url = "/top-headlines?country=us&apiKey=\(NetworkManager.apiKey)&pageSize=\(self.articlesNumber)"
        return try await manager.request(url: url, method: "get", type: NewsResponse.self).articles
    }
    
    func getArticles(page:Int) async throws -> [Card] {
        let url = "/top-headlines?country=us&apiKey=\(NetworkManager.apiKey)&pageSize=\(self.articlesNumber)&page=\(page)"
        let res = try await manager.request(url: url, method: "get", type: NewsResponse.self)
        if(res.totalResults ?? 0 < page * self.articlesNumber){
            return []
        }
            return res.articles
    }
    
    func getArticlesBySearch(word: String) async throws -> [Card] {
        let url = "/everything?q=\(word)&apiKey=\(NetworkManager.apiKey)"
        return try await manager.request(url: url, method: "get", type: NewsResponse.self).articles
    }
}

