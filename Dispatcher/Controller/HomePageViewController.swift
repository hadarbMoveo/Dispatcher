import UIKit

class HomePageViewController: UIViewController {

    let navigationBar = NavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegate = self
        navigationBar.setupNavigationBar(for: self)
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
