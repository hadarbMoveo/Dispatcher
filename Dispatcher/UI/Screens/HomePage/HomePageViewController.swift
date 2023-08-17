import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: HomePageViewModel = HomePageViewModel(repository: MockArticleRepository())
    var mockArticles:[Card] = []
    let navigationBar = NavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mockArticles = viewModel.repository.getArticles()
        initNavigationBar()
        initTableView()
    }
    
    func initNavigationBar() {
        navigationBar.delegate = self
        navigationBar.setupNavigationBar(for: self)
    }
    
    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName:String(describing: ArticleCell.self), bundle: nil), forCellReuseIdentifier: ArticleCell.identifier)
        tableView.rowHeight = 449
    }
}

extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath)
        as? ArticleCell
        let item = mockArticles[indexPath.row]
        cell?.initCell(article: item as? Article)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
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
