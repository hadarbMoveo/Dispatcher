import UIKit

class FavoritePageViewController: BaseViewController {
    
    let viewModel: FavoritePageViewModel = FavoritePageViewModel(repository: FavoriteFirestoreRepository())

    let vcView = FavoritePageView()
    override func loadView() {
        self.view = vcView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    func initTableView() {
        vcView.tableView.dataSource = self
        vcView.tableView.delegate = self
        vcView.tableView.register(UINib(nibName:String(describing: FavoriteCell.self), bundle: nil), forCellReuseIdentifier: FavoriteCell.identifier)
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
        cell?.setImage(urlImage: favArticle?.urlToImage ?? "")
//        cell?.searchLable.text=viewModel.recentSearches[indexPath.row]
//        cell?.removeSearchButton.isEnabled=true
//        cell?.index = Int(indexPath.row)
    

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

