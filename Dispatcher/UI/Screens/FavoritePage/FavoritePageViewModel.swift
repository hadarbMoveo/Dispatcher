//
//  FavoritePageViewModel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 04/09/2023.
//

import Foundation
class FavoritePageViewModel {
    
    let repository: FavoriteRepositoryProtocol
    var favArticles: [NewsArticle]
    
    init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
        favArticles = []
    }
    
    func loadFavoriteArticles() async throws {
        do {
            let documents = try await repository.getAllFavoriteArticles()
            var favoriteArticles: [NewsArticle] = []
            
            for document in documents {
                do {
                    let documentData = document.data()
                    let newsArticle = NewsArticle(
                        documentID: document.documentID,
                        author: documentData["author"] as? String ?? "",
                        title: documentData["title"] as? String ?? "",
                        description: documentData["description"] as? String ?? "",
                        urlToImage: documentData["urlToImage"] as? String ?? "",
                        publishedAt: documentData["publishedAt"] as? String ?? "",
                        content: documentData["content"] as? String ?? "",
                        isFavorite: true
                    )
                    
                    favoriteArticles.append(newsArticle)
                }
            }
            
            self.favArticles = favoriteArticles
            
        } catch {
            print(error)
            throw error
        }
    }
    
    
    func removeFavoriteByIndex(index: Int) async {
        let idDocumentToRemove: String = favArticles[index].documentID
        print(idDocumentToRemove)
        favArticles.remove(at: index)
        do {
            await repository.removeFavoriteArticle(documentID: idDocumentToRemove)
        }
    }
}
