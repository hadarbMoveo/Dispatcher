import UIKit

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create and set up the navigation bar
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.size.width, height: 44))

        view.addSubview(navigationBar)

        // Create a custom header view
        let headerHeight: CGFloat = 100
        let customHeaderView = UIView(frame: CGRect(x: 0, y: navigationBar.frame.maxY, width: view.frame.size.width, height: headerHeight))
        customHeaderView.backgroundColor = UIColor(red: 38.0/255.0, green: 33.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        
        // Add company logo to the left side of the custom header view
        let logoImageView = UIImageView(image: UIImage(named: "logo")) // Replace "CompanyLogo" with your image name in the asset catalog
        logoImageView.frame = CGRect(x: 16, y: 0, width: 40, height: customHeaderView.frame.size.height)
        logoImageView.contentMode = .scaleAspectFit
        customHeaderView.addSubview(logoImageView)
        
        // Add search button to the custom header view
        let searchButton = UIButton(type: .system)
        searchButton.frame = CGRect(x: customHeaderView.frame.size.width - 100, y: 0, width: 50, height: customHeaderView.frame.size.height)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .white
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        customHeaderView.addSubview(searchButton)
        
        // Add add button to the custom header view
        let addButton = UIButton(type: .system)
        addButton.frame = CGRect(x: customHeaderView.frame.size.width - 50, y: 0, width: 50, height: customHeaderView.frame.size.height)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .white
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        customHeaderView.addSubview(addButton)
        
        view.addSubview(customHeaderView)
    }

    @objc func searchButtonTapped() {
        print("Search button tapped")
    }

    @objc func addButtonTapped() {
        print("Add button tapped")
    }
}
