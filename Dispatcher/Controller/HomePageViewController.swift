import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data: [Card] = DataSource.getData()
    let navigationBar = NavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName:"ArticleCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        navigationBar.delegate = self
        navigationBar.setupNavigationBar(for: self)
        tableView.rowHeight = 449
    }
}

extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        as! ArticleCell
        let item = data[indexPath.row]
        
        if let article = item as? Article {
            cell.tagCard.text=article.tag
            cell.summaryCard.text=article.summary
            cell.authorCard.text=article.author
            cell.dateCard.text=article.date
            cell.titleCard.text=article.title
        }
        return cell
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
