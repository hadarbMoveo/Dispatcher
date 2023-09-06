import Foundation

protocol HomePageViewControllerDelegate: AnyObject {
    func reloadUI()
    func stopLoading()
    func search(word:String)
    func startLoading()
    func setFevorite(index: Int)
}

class HomePageViewModel {
    
    let repository: ArticleRepositoryProtocol
    let favoriteRepository : FavoriteRepositoryProtocol = FavoriteFirestoreRepository()
    var articles: [Card] = []
    weak var delegate: HomePageViewControllerDelegate?
    let defaults = UserDefaults.standard
    var page: Int
    var isFirstRun: Bool = true
    var isSearching: Bool = false
    
    init(repository: ArticleRepositoryProtocol) {
        self.repository = repository
        self.page = 1
    }
    
    func prepareForDisplay() async throws {
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
        var newsArticles = try await repository.getArticles(page: self.page)
        if !newsArticles.isEmpty {
            let favoriteArticles = getFavoriteArticles()
            for (index, article) in newsArticles.enumerated() {
                if let favoriteInfo = favoriteArticles.first(where: { $0[0] == article.title}) {
                    newsArticles[index].isFavorite = true
                    newsArticles[index].documentID = favoriteInfo[1]
                }
            }
            self.articles.append(contentsOf: newsArticles)
            self.page += 1
            reloadUI()
            return
        }
            delegate?.stopLoading()
    }
        
    func search(word: String) async throws {
        isSearching = true
        self.articles = try await repository.getArticlesBySearch(word: word)
        reloadUI()
    }
    
    func setFavoriteByIndex(index: Int) async {
        articles[index].isFavorite.toggle()
        var isFavorite: Bool = articles[index].isFavorite
        if isFavorite {
            do {
                let id = await favoriteRepository.addNewFavoriteArticle(article: articles[index] as! NewsArticle)
                articles[index].documentID = id
                if let newsArticle = articles[index] as? NewsArticle {
                    addFavoriteArticleToUserDefault(title:newsArticle.title ?? "" , documentID: newsArticle.documentID)
                }

            }
        } else {
            let documentID = articles[index].documentID
            await favoriteRepository.removeFavoriteArticle(documentID: documentID)
            removeFavoriteArticleFromUserDefault(documentID: documentID)
        }
        
        delegate?.reloadUI()
    }
    
    func addFavoriteArticleToUserDefault(title: String, documentID: String) {
        if let savedEmail = defaults.string(forKey: "email") {
            var userFavorites = UserDefaults.standard.dictionary(forKey: "userFavorites") as? [String: [[String]]] ?? [:]
            var favoritesForUser = userFavorites[savedEmail] ?? []
            favoritesForUser.append([title, documentID])
            userFavorites[savedEmail] = favoritesForUser
            UserDefaults.standard.set(userFavorites, forKey: "userFavorites")
        }
    }
    
    func removeFavoriteArticleFromUserDefault(documentID: String) {
        if let savedEmail = defaults.string(forKey: "email") {
            var userFavorites = UserDefaults.standard.dictionary(forKey: "userFavorites") as? [String: [[String]]] ?? [:]
            var favoritesForUser = userFavorites[savedEmail] ?? []
            favoritesForUser = favoritesForUser.filter { $0[1] != documentID }
            userFavorites[savedEmail] = favoritesForUser
            UserDefaults.standard.set(userFavorites, forKey: "userFavorites")
        }
    }
    
    func getFavoriteArticles() -> [[String]] {
        if let savedEmail = defaults.string(forKey: "email") {
            let userFavorites = UserDefaults.standard.dictionary(forKey: "userFavorites") as? [String: [[String]]] ?? [:]
            return userFavorites[savedEmail] ?? []
        }
        return []
    }
    
}
