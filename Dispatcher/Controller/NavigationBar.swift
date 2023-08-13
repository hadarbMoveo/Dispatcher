import UIKit

class NavigationBar {
    
    static func setupNavigationBar(for viewController: UIViewController) {
        let iconImage = UIImage(named: "logo")
        let iconImageView = UIImageView(image: iconImage)
        iconImageView.contentMode = .scaleAspectFit
        let iconBarButton = UIBarButtonItem(customView: iconImageView)
        
        let bellImage = UIImage(systemName: "bell.badge")
        let alertButton = UIBarButtonItem(image: bellImage, style: .plain, target: viewController, action: #selector(NavigationBar.alertButtonTapped))
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: viewController, action: #selector(NavigationBar.searchButtonTapped))
        
        viewController.navigationItem.rightBarButtonItems = [alertButton, searchButton]
        viewController.navigationItem.leftBarButtonItems = [iconBarButton]
        
    }
    
    
    @objc static func alertButtonTapped() {
        print("Alert button tapped")
    }
    
    @objc static func searchButtonTapped() {
        print("Search button tapped")
    }
    
    
}

