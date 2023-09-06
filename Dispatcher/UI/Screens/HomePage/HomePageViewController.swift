import UIKit
import Kingfisher

class HomePageViewController: BaseViewController {
    
    let viewModel: HomePageViewModel = HomePageViewModel(repository: ArticleRepository())
    
    @IBOutlet weak var tableView: UITableView?
    
    override var isSearchHidden: Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initViewModel()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            try await viewModel.prepareForDisplay()
        }
    }
    
    func initTableView() {
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(UINib(nibName:String(describing: ArticleCell.self), bundle: nil), forCellReuseIdentifier: ArticleCell.identifier)
    }
    
    func initViewModel() {
        viewModel.delegate = self
        self.startLoading()
        
        Task {
            try await viewModel.getData()
        }
    }
    
    override func searchButtonTapped() {
        let searchScreen = SearchPageViewController()
        searchScreen.delegate = self
        navigationController?.pushViewController(searchScreen, animated: false)
    }
}

extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath)
        as? ArticleCell
        let newArticle = viewModel.articles[indexPath.row] as? NewsArticle
        cell?.initCell(with: newArticle)
        cell?.delegate = self
        cell?.index = Int(indexPath.row)
        cell?.setImage(urlImage: newArticle?.urlToImage ?? "")

        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 449
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        loadMoreDataIfNeeded(for: indexPath.row)
    }
    
    func loadMoreDataIfNeeded(for index: Int) {
        let didReachPaginationCell = index == viewModel.articles.count-1
        if didReachPaginationCell && !viewModel.isSearching {
            self.startLoading()
            Task {
                try await viewModel.getData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleSelected = viewModel.articles[indexPath.row] as? NewsArticle
        let viewModelForDetails = ArticleDetailsPageViewModel(article: articleSelected)
        navigationController?.pushViewController(ArticleDetailsPageViewController(viewModel: viewModelForDetails), animated: false)
    }
}


extension HomePageViewController: HomePageViewControllerDelegate {
    func reloadUI() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func startLoading() {
        showActivityIndicator()
    }
    
    func stopLoading() {
        hideActivityIndicator()
    }
    
    @MainActor
    
    func search(word:String) {
        Task {
            do {
                self.startLoading()
                try await viewModel.search(word: word)
            } catch let e {
                print(e)
            }
        }
    }
    
    func setFevorite(index: Int) {
        viewModel.setFavoriteByIndex(index: index)
        print("\(index)")
    }
}


