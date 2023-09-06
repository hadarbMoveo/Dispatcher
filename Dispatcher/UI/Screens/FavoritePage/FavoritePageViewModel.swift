//
//  FavoritePageViewModel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 04/09/2023.
//

import Foundation
class FavoritePageViewModel {

    let repository: FavoriteRepositoryProtocol
    let favArticles: [NewsArticle] = [
        NewsArticle(author: "hadar", title: "hadar", description: "hadar", urlToImage: "", publishedAt: "hadar", content: "hadar", isFavorite: true),
        NewsArticle(author: "hadar", title: "hadar", description: "hadar", urlToImage: "", publishedAt: "hadar", content: "hadar", isFavorite: true)
    ]
    
    init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
}