import UIKit

protocol HeaderDelegate: AnyObject {
    func alertButtonTapped()
    func searchButtonTapped()
}

class NavigationBar {
    weak var delegate: HeaderDelegate?
    
    func setupNavigationBar(for viewController: UIViewController) {
        let iconImage = UIImage(named: "logo")
        let iconImageView = UIImageView(image: iconImage)
        iconImageView.contentMode = .scaleAspectFit
        let iconBarButton = UIBarButtonItem(customView: iconImageView)
        
        let alertButton = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .plain, target: self, action: #selector(self.alertButtonTapped))
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.searchButtonTapped))
        searchButton.isHidden = true
        if let homeViewController = viewController as? HomePageViewController {
            searchButton.isHidden = false
        }
        viewController.navigationItem.rightBarButtonItems = [alertButton, searchButton]
        viewController.navigationItem.leftBarButtonItems = [iconBarButton]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "Primary")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "TextColor") ?? .white]
        
        viewController.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        viewController.navigationController?.navigationBar.standardAppearance = appearance
    }
    
    @objc private func alertButtonTapped() {
        delegate?.alertButtonTapped()
    }
    
    @objc private func searchButtonTapped() {
        delegate?.searchButtonTapped()
    }

}








