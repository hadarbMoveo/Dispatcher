import UIKit

class HeaderViewController: UIViewController {
    
    let customHeaderView = UIView()
    let dispatcherLogo = UIImageView()
    let searchButton = UIButton(type: .system)
    let addButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
    }
    
    func setupHeaderView() {
        let headerHeight: CGFloat = 100
        customHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: headerHeight)
        customHeaderView.backgroundColor = UIColor(red: 38.0/255.0, green: 33.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        
        setupLogo()
        setupSearchButton()
        setupAddButton()
        
        view.addSubview(customHeaderView)
    }
    
    func setupLogo() {
        dispatcherLogo.image = UIImage(named: "logo")
        dispatcherLogo.frame = CGRect(x: 16, y: 20, width: 40, height: customHeaderView.frame.size.height)
        dispatcherLogo.contentMode = .scaleAspectFit
        customHeaderView.addSubview(dispatcherLogo)
    }
    
    func setupSearchButton() {
        searchButton.frame = CGRect(x: customHeaderView.frame.size.width - 100, y: 20, width: 50, height: customHeaderView.frame.size.height)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .white
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        customHeaderView.addSubview(searchButton)
    }
    
    func setupAddButton() {
        addButton.frame = CGRect(x: customHeaderView.frame.size.width - 50, y: 20, width: 50, height: customHeaderView.frame.size.height)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .white
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        customHeaderView.addSubview(addButton)
    }
    
    @objc func searchButtonTapped() {
        print("Search button tapped")
    }
    
    @objc func addButtonTapped() {
        print("Add button tapped")
    }
}






