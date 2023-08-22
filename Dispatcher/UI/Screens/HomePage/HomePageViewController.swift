import UIKit
import Kingfisher

class HomePageViewController: UIViewController{
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    let viewModel: HomePageViewModel = HomePageViewModel(repository: ArticleRepository())
    let navigationBar = NavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initTableView()
        initViewModel()
    }
    
    func initNavigationBar() {
        navigationBar.delegate = self
        navigationBar.setupNavigationBar(for: self)
    }
    
    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName:String(describing: ArticleCell.self), bundle: nil), forCellReuseIdentifier: ArticleCell.identifier)
    }
    
    func initViewModel(){
        viewModel.delegate = self
        self.startLoading()
        viewModel.getData()
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
        setImage(cell,url:URL(string: newArticle?.urlToImage ?? ""))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 449
    }
    
    func setImage(_ cell:ArticleCell?,url :URL?){
        cell?.imageUrlCard.kf.setImage(with:url)
    }
}

extension HomePageViewController: HeaderDelegate {
    
    func alertButtonTapped() {
        print("Alert button tapped")
    }
    
    func searchButtonTapped() {
        print("Search button tapped")
    }
}

extension HomePageViewController: HomePageDelegate {
    func reloadUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func startLoading() {
        loader.startAnimating()
    }
    
    func stopLoading() {
        loader.stopAnimating()
        loader.isHidden = true
    }
}

