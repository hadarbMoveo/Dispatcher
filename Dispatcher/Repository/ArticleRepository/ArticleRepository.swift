//
//  ArticleRepository.swift
//  Dispatcher
//
//  Created by Hadar Basson on 20/08/2023.
//
import Foundation
class ArticleRepository: ArticleRepositoryProtocol {

    let manager: NetworkManager = NetworkManager()
    let articlesNumber = 5

    
    func getArticles() async throws -> [Card] {
        let url = "/articles/getAll"
        return try await manager.request(url: url, method: "get", type: NewsResponse.self).articles
    }
    
    
    func getArticles(page: Int) async throws -> [Card] {
        let url = "/articles/getAll?pageSize=\(self.articlesNumber)?page=\(page)"
        let res = try await manager.request(url: url, method: "get", type: NewsResponse.self)
        if(shouldFetchMoreArticles(currentPage: page, totalResults: res.totalResults)){
            return res.articles
        }
        return []
    }
    
    func getArticlesBySearch(word: String) async throws -> [Card] {
        let url = "/articles/getSearch?q=\(word)"

        return try await manager.request(url: url, method: "get", type: NewsResponse.self).articles
    }
    
    func shouldFetchMoreArticles(currentPage: Int, totalResults: Int?) -> Bool {
        guard let totalResults = totalResults else {
            return false
        }
        
        let articlesUntilNow = currentPage * self.articlesNumber
        return totalResults >= articlesUntilNow
    }
}

