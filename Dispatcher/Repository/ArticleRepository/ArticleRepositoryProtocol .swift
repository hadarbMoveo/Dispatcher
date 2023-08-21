import Foundation

protocol ArticleRepositoryProtocol {
    func getArticles(completion:@escaping([Card])->Void)
}
