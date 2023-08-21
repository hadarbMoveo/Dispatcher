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
        let apiKey = "ef5133dd364c41719494a74ce614d679"
        let articlesNumber = 7
        let url = String("https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)&pageSize=\(articlesNumber)")
        manager.request(url: url, method: "get", completion: { data in
            do {
                let jsonData = try JSONDecoder().decode(NewsResponse.self, from: data as! Data)
                let articles = jsonData.articles
                print(articles)
                completion(articles)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        })
    }
}
