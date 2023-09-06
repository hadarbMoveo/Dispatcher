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

    func addNewFavoriteArticle(article: NewsArticle) async -> String {
        do {
            let data: [String: Any] = [
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
    
    
    func removeFavoriteArticle(documentID: String) async {
        do {
            try await db.collection("favoriteArticles").document(documentID).delete()
        } catch {
            print("Error removing document: \(error)")
        }
    }
    
    func getAllFavoriteArticles() async throws -> [QueryDocumentSnapshot] {
        let querySnapshot = try await db.collection("favoriteArticles").getDocuments()
        return querySnapshot.documents
    }

}
