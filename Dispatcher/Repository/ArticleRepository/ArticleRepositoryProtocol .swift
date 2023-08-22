import Foundation

protocol ArticleRepositoryProtocol {
    func getArticles(completion:@escaping([Card])->Void)
    func getArticles() async throws -> [Card]
}
