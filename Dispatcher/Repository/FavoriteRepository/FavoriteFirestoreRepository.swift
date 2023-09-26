//
//  FavoriteFirestoreRepository.swift
//  Dispatcher
//
//  Created by Hadar Basson on 04/09/2023.
//

import Foundation
import FirebaseFirestore

class FavoriteFirestoreRepository: FavoriteRepositoryProtocol {
    
    let db = Firestore.firestore()
    let defaults = UserDefaults.standard

    func addNewFavoriteArticle(article: NewsArticle) async throws -> String {
        let savedEmail = defaults.string(forKey: "email")
        do {
            let data: [String: Any] = [
                "user":savedEmail,
                "title": article.title ?? "",
                "description": article.description ?? "",
                "author": article.author ?? "",
                "urlToImage": article.urlToImage ?? "",
                "publishedAt": article.publishedAt ?? "",
                "content": article.content ?? ""
            ]
            
            let newDocument = db.collection("favoriteArticles").addDocument(data: data)
            return newDocument.documentID
        }
    }
    
    func getAllFavoriteArticles() async throws -> GetFavoriteArticlesResponse {
        return GetFavoriteArticlesResponse(articles: [])
    }
    
    func removeFavoriteArticle(documentID: String) async {
        do {
            try await db.collection("favoriteArticles").document(documentID).delete()
            removeFavoriteArticleFromUserDefault(documentID:documentID)
        } catch {
            print("Error removing document: \(error)")
        }
    }
    
    func getAllFavoriteArticles() async throws -> [QueryDocumentSnapshot] {
        let querySnapshot = try await db.collection("favoriteArticles").getDocuments()
        return querySnapshot.documents
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
