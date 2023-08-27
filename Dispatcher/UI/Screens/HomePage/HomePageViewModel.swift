import Foundation

protocol HomePageDelegate: AnyObject {
    func reloadUI()
    func stopLoading()
    func search(word:String)
    func startLoading()
}

class HomePageViewModel {
    
    let repository: ArticleRepositoryProtocol
    var articles: [Card] = []
    weak var delegate: HomePageDelegate?
    var page:Int
    var isFirstRun: Bool = true
    var isSearching: Bool = false
    
    init(repository: ArticleRepositoryProtocol) {
        self.repository = repository
        self.page = 1
    }
    
    func willAppear() async throws {
        if !isFirstRun && !isSearching {
            delegate?.startLoading()
            resetNewsList()
            try await getData()
        }
        
        isFirstRun = false
        isSearching = false
    }
    
    func reloadUI() {
        delegate?.reloadUI()
        delegate?.stopLoading()
    }
    
    
    func resetNewsList() {
        self.articles = []
        self.page = 1
    }
    
    func getData() async throws {
        let newsArticles = try await repository.getArticles(page: self.page)
        if !newsArticles.isEmpty {
            self.articles.append(contentsOf: newsArticles)
            self.page += 1
            reloadUI()
            return
        }
        else {
            delegate?.stopLoading()
        }
    }
        
    func search(word:String) async throws {
        isSearching = true
        self.articles = try await repository.getArticlesBySearch(word: word)
        reloadUI()
    }
    
}
