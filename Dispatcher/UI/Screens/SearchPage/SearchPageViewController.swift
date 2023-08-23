//
//  SearchPageViewController.swift
//  Dispatcher
//
//  Created by Hadar Basson on 22/08/2023.
//
import UIKit
class SearchPageViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    let customColor = UIColor(red: 0.973, green: 0.973, blue: 1, alpha: 1)
    let searchBar = UISearchBar()
    let recentSearchesView = UIView()
    let tableView = UITableView()
    let searchButton = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    let container = UIView()
    let lable = UILabel()
    let clearButton = UIButton(type: .system)
    
    
    
    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.searchTextField.backgroundColor = .white
        searchBar.backgroundColor = .white
        searchBar.searchTextField.leftViewMode = .never
        container.backgroundColor = .white
        clearButton.backgroundColor = .lightGray
        clearButton.setTitle("CLEAR", for:. normal)
        clearButton.setTitleColor(.darkGray, for: .normal)
        lable.text = "RECENT SEARCHES"
        lable.textColor = .black
        tableView.backgroundColor = customColor
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchButton.setBackgroundImage(UIImage(named: "search"), for: .normal) // Set the button's background image
        
        backButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        backButton.setBackgroundImage(UIImage(named: "back"), for: .normal) // Set the button's background image

        container.addSubview(searchButton)
        container.addSubview(searchBar)
        container.addSubview(backButton)
        view.addSubview(container)
        

        recentSearchesView.backgroundColor = customColor
        recentSearchesView.addSubview(clearButton)
        recentSearchesView.addSubview(lable)
        view.addSubview(recentSearchesView)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName:String(describing: SearchCell.self), bundle: nil), forCellReuseIdentifier: SearchCell.identifier)
        view.addSubview(tableView)
        setupConstraints()
    }

    @objc func searchButtonTapped() {
        if let searchText = searchBar.text {
            print("Performing search for: \(searchText)")
        }
    }

    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        recentSearchesView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        lable.translatesAutoresizingMaskIntoConstraints = false
        clearButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.heightAnchor.constraint(equalToConstant: 80),
            
            searchBar.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -60),
            searchBar.heightAnchor.constraint(equalToConstant: 80),
            
            searchButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo:container.centerYAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            backButton.centerYAnchor.constraint(equalTo:container.centerYAnchor),
            
            recentSearchesView.topAnchor.constraint(equalTo: container.bottomAnchor),
            recentSearchesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recentSearchesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recentSearchesView.heightAnchor.constraint(equalToConstant: 80), // Adjust height as needed
            
     
            lable.leadingAnchor.constraint(equalTo: recentSearchesView.leadingAnchor,constant: 10),
            lable.centerYAnchor.constraint(equalTo:recentSearchesView.centerYAnchor),
            
            clearButton.trailingAnchor.constraint(equalTo: recentSearchesView.trailingAnchor,constant: -10),
            clearButton.centerYAnchor.constraint(equalTo:recentSearchesView.centerYAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: 60),

            tableView.topAnchor.constraint(equalTo: recentSearchesView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    // MARK: - Table View Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}







