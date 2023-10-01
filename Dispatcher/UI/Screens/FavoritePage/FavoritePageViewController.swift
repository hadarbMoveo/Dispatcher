import UIKit

class FavoritePageViewController: BaseViewController {
 
    let viewModel: FavoritePageViewModel = FavoritePageViewModel(repository: FavoriteRepository())

    let vcView = FavoritePageView()
    override func loadView() {
        self.view = vcView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.startLoading()
        Task {
            try await viewModel.loadFavoriteArticles()
            self.reloadUI()
            self.stopLoading()
        }
    }
    
    func initTableView() {
        vcView.tableView.dataSource = self
        vcView.tableView.delegate = self
        vcView.tableView.register(UINib(nibName:String(describing: FavoriteCell.self), bundle: nil), forCellReuseIdentifier: FavoriteCell.identifier)
    }
    
    func initViewModel() {
        self.startLoading()
        Task {
            try await viewModel.loadFavoriteArticles()
            self.reloadUI()
            self.stopLoading()
        }
    }
}



extension FavoritePageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath)
        as? FavoriteCell
        let favArticle = viewModel.favArticles[indexPath.row] as? NewsArticle
        cell?.initCell(with: favArticle)
        cell?.delegate = self
        cell?.index = Int(indexPath.row)
        cell?.setImage(urlImage: favArticle?.urlToImage ?? "")

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleSelected = viewModel.favArticles[indexPath.row]
        let viewModelForDetails = ArticleDetailsPageViewModel(article: articleSelected)
        navigationController?.pushViewController(ArticleDetailsPageViewController(viewModel: viewModelForDetails), animated: false)
        
    }
}

extension FavoritePageViewController: FavoriteViewControllerDelegate {
    func reloadUI() {
        DispatchQueue.main.async {
            self.vcView.tableView.reloadData()
        }
    }
    
    func startLoading() {
        showActivityIndicator()
    }
    
    func stopLoading() {
        hideActivityIndicator()
    }
    
    @MainActor
    func remove(index: Int) {
        Task {
            await viewModel.removeFavoriteByIndex(index: index)
            self.reloadUI()
        }
    }
}

