import UIKit

class FavoritePageViewController: UIViewController {
    let navigationBar = NavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
    }
    
    func initNavigationBar() {
        navigationBar.delegate = self
        navigationBar.setupNavigationBar(for: self)
    }
}

extension FavoritePageViewController: HeaderDelegate {
    
    func alertButtonTapped() {
        print("Alert button tapped")
    }
    
    func searchButtonTapped() {
        print("Search button tapped")
    }
}
