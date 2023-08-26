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
    var page:Int

    init(repository: ArticleRepositoryProtocol) {
        self.repository = repository
        self.page = 1
    }
    
    func getData() {
        repository.getArticles { data in
            self.articles = data
            self.delegate?.reloadUI()
            self.delegate?.stopLoading()
        }
    }

    

//    func getData() async throws {
//            self.articles = try await repository.getArticles()
//            delegate?.reloadUI()
//            delegate?.stopLoading()
//    }
    
    func reset(){
        self.articles = []
        self.page = 1
    }
    
    
    func getData() async throws {
            let newsArticles = try await repository.getArticles(page: self.page)
            if !newsArticles.isEmpty {
                self.articles.append(contentsOf: newsArticles)
                self.page += 1
                delegate?.reloadUI()
                delegate?.stopLoading()
                return
            }
            else{
                delegate?.stopLoading()
            }
    }
    
    func getData(isPaginationOn:Bool) async throws {
            self.articles = try await repository.getArticles()
            delegate?.reloadUI()
            delegate?.stopLoading()
    }
    
    
    func getMoreArticles() async throws {
        
    }
    
    func search(word:String) async throws {
        self.articles = try await repository.getArticlesBySearch(word: word)
        delegate?.reloadUI()
        delegate?.stopLoading()
    }
}
