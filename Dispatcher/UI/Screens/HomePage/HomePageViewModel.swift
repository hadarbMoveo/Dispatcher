import Foundation

protocol HomePageDelegate: AnyObject {
    func reloadUI()
    func stopLoading()
}

class HomePageViewModel {
    
    let repository: ArticleRepositoryProtocol
    var articles: [Card] = []
    weak var delegate: HomePageDelegate?
    
    init(repository: ArticleRepositoryProtocol) {
        self.repository = repository
    }
    
    func getData() {
        repository.getArticles { data in
            self.articles = data
            self.delegate?.reloadUI()
            self.delegate?.stopLoading()
        }
    }

    func getData() async throws {
            self.articles = try await repository.getArticles()
            delegate?.reloadUI()
            delegate?.stopLoading()
    }
}
