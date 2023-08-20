import Foundation

class HomePageViewModel {

    let repository: ArticleRepositoryProtocol
    var articles: [Card] = []
    
    init(repository: ArticleRepositoryProtocol) {
      self.repository = repository
      repository.getArticles{ data in
          self.articles = data
        }
    }
}
