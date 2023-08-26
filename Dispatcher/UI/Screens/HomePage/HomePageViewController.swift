import UIKit
import Kingfisher

class HomePageViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView?
    let viewModel: HomePageViewModel = HomePageViewModel(repository: ArticleRepository())
    var isFirstRun: Bool = true
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !isFirstRun && !isSearching {
            self.startLoading()
            Task {
                viewModel.reset()
                try await viewModel.getData()
            }
        }

        isFirstRun = false
        isSearching = false
    }
    
    func initTableView() {
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(UINib(nibName:String(describing: ArticleCell.self), bundle: nil), forCellReuseIdentifier: ArticleCell.identifier)
    }
    
    func initViewModel(){
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
        cell?.setImage(urlImage: newArticle?.urlToImage ?? "")
        if(indexPath.row == viewModel.articles.count-1 && isSearching==false){
            self.startLoading()
            Task {
                try await viewModel.getData()
            }
        }
        return cell ?? UITableViewCell()
    }
    
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 449
    }
}


extension HomePageViewController: HomePageDelegate {
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
    func search(word:String){
        isSearching = true
        Task {
            do {
                self.startLoading()
                try await viewModel.search(word: word)
            } catch let e {
                print(e)
            }
            
        }
    }
}


