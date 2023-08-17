import Foundation

class HomePageViewModel {

    let repository:ArticleRepository
    
    init(repository: ArticleRepository) {
      self.repository = repository
    }
}
