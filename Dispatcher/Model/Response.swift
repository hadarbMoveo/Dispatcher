//
//  Response.swift
//  Dispatcher
//
//  Created by Hadar Basson on 20/09/2023.
//

import Foundation
protocol Response {}

struct addFavoriteResponse: Decodable, Response {
    let ID: String
}

struct favoriteArticle: Decodable {
    let _id: String
    let author: String
    let content: String
    let description: String
    let publishedAt: String
    let title: String
    let urlToImage: String
    let user: String
}

struct getFavoriteArticlesResponse: Decodable {
    let articles: [favoriteArticle]
}

struct removeFavoriteResponse: Decodable {
    let message: String
}
