import Foundation

protocol HomePageDelegate: AnyObject {
    func reloadData()
}

class HomePageViewModel {

    let repository: ArticleRepositoryProtocol
    var articles: [Card] = []
    weak var delegate: HomePageDelegate?
    
    init(repository: ArticleRepositoryProtocol) {
      self.repository = repository
//      repository.getArticles{ data in
//          self.articles = data
//        }
    }
    
    func getData(){
        repository.getArticles{ data in
            self.articles = data
            self.delegate?.reloadData()
        }
    }
}
