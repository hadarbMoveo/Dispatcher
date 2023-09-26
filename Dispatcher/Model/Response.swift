//
//  Response.swift
//  Dispatcher
//
//  Created by Hadar Basson on 20/09/2023.
//

import Foundation

struct AddFavoriteResponse: Decodable{
    let ID: String
}

struct FavoriteArticle: Decodable {
    let _id: String
    let author: String
    let content: String
    let description: String
    let publishedAt: String
    let title: String
    let urlToImage: String
    let user: String
}

struct GetFavoriteArticlesResponse: Decodable {
    let articles: [FavoriteArticle]
}

struct RemoveFavoriteResponse: Decodable {
    let message: String
}

struct AuthResponse: Decodable {
    let status: String
    let token: String
    let message: String
}

struct LogoutResponse: Decodable {
    let message: String
}

struct MyError: Error {
    let message: String
}

