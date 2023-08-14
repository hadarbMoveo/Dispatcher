import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data: [Item] = DataSource.getData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource=self
        tableView.delegate=self
        
    }
    

}

extension HomePageViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        let item = data[indexPath.row]
        
        if let article = item as? Article {
            cell.textLabel?.text = article.title
        }
        
        return cell;
    }
    
    
}

extension HomePageViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
