//
//  FavoriteRepository.swift
//  Dispatcher
//
//  Created by Hadar Basson on 19/09/2023.
//

import Foundation
class FavoriteRepository: FavoriteRepositoryProtocol {
        
    let manager: NetworkManager = NetworkManager()
    let defaults = UserDefaults.standard
    
    func addNewFavoriteArticle(article: NewsArticle) async throws -> String {
        let savedEmail = defaults.string(forKey: "email")
        let article: [String:String] = [
            "user": savedEmail ?? "",
            "title": article.title ?? "",
            "description": article.description ?? "",
            "author": article.author ?? "",
            "urlToImage": article.urlToImage ?? "",
            "publishedAt": article.publishedAt ?? "",
            "content": article.content ?? ""
        ]
        
        let url = "/articles/addFavorite"
          do {
              let response = try await manager.request(url: url, method: "post", type: addFavoriteResponse.self, params: article)
    
              return response.ID
          } catch {
              throw error
          }
    }
        
    func removeFavoriteArticle(documentID: String) async {
        let url = "/articles/removeFavorite/\(documentID)"
          do {
              let response = try await manager.request(url: url, method: "delete", type: removeFavoriteResponse.self)
              
          } catch {
              print("Error removing document: \(error)")
          }
    }
    
    
    func getAllFavoriteArticles() async throws -> getFavoriteArticlesResponse {
          let url = "/articles/getFavorites"

          do {
              let articles: getFavoriteArticlesResponse = try await manager.request(
                  url: url,
                  method: "get",
                  type: getFavoriteArticlesResponse.self
              )
              print(articles)
              return articles
          } catch {
              throw error
          }
      }
    
    func removeFavoriteArticleFromUserDefault(documentID: String) {
        if let savedEmail = defaults.string(forKey: "email") {
            var userFavorites = UserDefaults.standard.dictionary(forKey: "userFavorites") as? [String: [[String]]] ?? [:]
            var favoritesForUser = userFavorites[savedEmail] ?? []
            favoritesForUser = favoritesForUser.filter { $0[1] != documentID }
            userFavorites[savedEmail] = favoritesForUser
            UserDefaults.standard.set(userFavorites, forKey: "userFavorites")
        }
    }

}
