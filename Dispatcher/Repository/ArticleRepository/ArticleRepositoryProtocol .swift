import Foundation

protocol ArticleRepositoryProtocol {
    func getArticles() async throws -> [Card]
    func getArticlesBySearch(word:String) async throws -> [Card]
    func getArticles(page:Int) async throws -> [Card]
}
