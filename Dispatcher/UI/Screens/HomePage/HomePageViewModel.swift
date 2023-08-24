import Foundation

protocol HomePageDelegate: AnyObject {
    func reloadUI()
    func stopLoading()
    func search(word:String)
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
    
    func getData(isPaginationOn:Bool) async throws {
            self.articles = try await repository.getArticles()
            delegate?.reloadUI()
            delegate?.stopLoading()
    }
    
    
    func getMoreArticles(page: Int) async throws {
    }
    
    func search(word:String) async throws {
        self.articles = try await repository.getArticlesBySearch(word: word)
//        print(articles)
        delegate?.reloadUI()
        delegate?.stopLoading()
    }
}
