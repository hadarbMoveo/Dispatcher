import UIKit

class FavoritePageViewController: BaseViewController {
    
    let viewModel: SearchPageViewModel = SearchPageViewModel()

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
        vcView.tableView.register(UINib(nibName:String(describing: SearchCell.self), bundle: nil), forCellReuseIdentifier: SearchCell.identifier)
    }
    
}

extension FavoritePageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath)
        as? SearchCell
        cell?.searchLable.text=viewModel.recentSearches[indexPath.row]
        cell?.removeSearchButton.isEnabled=true
        cell?.index = Int(indexPath.row)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

