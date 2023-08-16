import UIKit

class FavoritePageViewController: UIViewController {

    let navigationBar = NavigationBar()
   // let viewModel = FavoritePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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