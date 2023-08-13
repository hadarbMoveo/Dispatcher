import UIKit

class HeaderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let headerHeight: CGFloat = 100
        let customHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: headerHeight))
        customHeaderView.backgroundColor = UIColor(red: 38.0/255.0, green: 33.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        

        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.frame = CGRect(x: 16, y: 20, width: 40, height: customHeaderView.frame.size.height)
        logoImageView.contentMode = .scaleAspectFit
        customHeaderView.addSubview(logoImageView)
        

        let searchButton = UIButton(type: .system)
        searchButton.frame = CGRect(x: customHeaderView.frame.size.width - 100, y: 20, width: 50, height: customHeaderView.frame.size.height)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .white
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        customHeaderView.addSubview(searchButton)
        

        let addButton = UIButton(type: .system)
        addButton.frame = CGRect(x: customHeaderView.frame.size.width - 50, y: 20, width: 50, height: customHeaderView.frame.size.height)
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
