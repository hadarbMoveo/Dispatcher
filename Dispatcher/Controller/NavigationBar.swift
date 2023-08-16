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
        
        viewController.navigationItem.rightBarButtonItems = [alertButton, searchButton]
        viewController.navigationItem.leftBarButtonItems = [iconBarButton]
        
    
    }
    
    @objc private func alertButtonTapped() {
        delegate?.alertButtonTapped()
    }
    
    @objc private func searchButtonTapped() {
        delegate?.searchButtonTapped()
    }
}








