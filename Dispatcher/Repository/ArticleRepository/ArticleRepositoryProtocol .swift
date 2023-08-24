import Foundation

protocol ArticleRepositoryProtocol {
    func getArticles(completion:@escaping([Card])->Void)
    func getArticles() async throws -> [Card]
    func getArticlesBySearch(word:String) async throws -> [Card]
}
