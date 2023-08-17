import Foundation

class HomePageViewModel {

    let repository: ArticleRepositoryProtocol
    var articles: [Card] = []
    
    init(repository: ArticleRepositoryProtocol ) {
      self.repository = repository
      articles = repository.getArticles()
    }
}
