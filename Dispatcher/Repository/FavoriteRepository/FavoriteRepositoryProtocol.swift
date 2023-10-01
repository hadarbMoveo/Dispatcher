//
//  FavoriteRepositoryProtocol.swift
//  Dispatcher
//
//  Created by Hadar Basson on 04/09/2023.
//
import FirebaseFirestore
import Foundation

protocol FavoriteRepositoryProtocol {
    func addNewFavoriteArticle(article:NewsArticle) async throws-> String
    func removeFavoriteArticle(documentID: String) async -> Void
    func getAllFavoriteArticles() async throws -> GetFavoriteArticlesResponse
}
