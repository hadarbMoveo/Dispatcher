import UIKit

class UserPageViewController: UIViewController, HeaderDelegate {
    let navigationBar = NavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegate = self
        navigationBar.setupNavigationBar(for: self)
    }
    
    func alertButtonTapped() {
        print("Alert button tapped")
    }

    func searchButtonTapped() {
        print("Search button tapped")
    }
    
    
}
