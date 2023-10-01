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
    let defaults = UserDefaults.standard
    
    init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
        favArticles = []
    }
    

    func loadFavoriteArticles() async throws {
        do {
            let documents = try await repository.getAllFavoriteArticles().articles
            var favoriteArticles: [NewsArticle] = []

            for document in documents {
                do {
                        let newsArticle = NewsArticle(
                            documentID: document._id,
                            author: document.author,
                            title: document.title,
                            description: document.description,
                            urlToImage: document.urlToImage,
                            publishedAt: document.publishedAt,
                            content: document.content,
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
        favArticles.remove(at: index)
        do {
            await repository.removeFavoriteArticle(documentID: idDocumentToRemove)
        }
    }
}
