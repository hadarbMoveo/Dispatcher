import UIKit

class UserPageViewController: UIViewController {
    let navigationBar = NavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegate = self
        navigationBar.setupNavigationBar(for: self)
    }
    
}

extension UserPageViewController: HeaderDelegate {
    
    func alertButtonTapped() {
        print("Alert button tapped")
    }

    func searchButtonTapped() {
        print("Search button tapped")
    }
}
