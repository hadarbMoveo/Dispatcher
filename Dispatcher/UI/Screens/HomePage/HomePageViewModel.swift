import Foundation

protocol HomePageDelegate: AnyObject {
    func reloadData()
    func startLoading()
    func stopLoading()
}

class HomePageViewModel {

    let repository: ArticleRepositoryProtocol
    var articles: [Card] = []
    weak var delegate: HomePageDelegate?
    
    init(repository: ArticleRepositoryProtocol) {
      self.repository = repository
    }
    
    func reloadData(){
        self.delegate?.startLoading()
        repository.getArticles{ data in
            self.articles = data
            self.delegate?.reloadData()
            self.delegate?.stopLoading()
        }
    }
}
