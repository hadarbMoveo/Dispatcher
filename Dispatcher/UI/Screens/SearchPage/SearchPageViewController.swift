//
//  SearchPageViewController.swift
//  Dispatcher
//
//  Created by Hadar Basson on 22/08/2023.
//
import UIKit
class SearchPageViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, SearchDelegate {
    let viewModel: SearchPageViewModel = SearchPageViewModel()
    weak var delegate: HomePageDelegate?
    // MARK: - Properties
    let customColor = UIColor(red: 0.973, green: 0.973, blue: 1, alpha: 1)
    
//    let vcView = SearchPageView()
//    override func loadView() {
//        self.view = vcView
//    }
    
    lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.searchTextField.backgroundColor = .white
        searchBar.backgroundColor = .white
        searchBar.searchTextField.leftViewMode = .never
        return searchBar
    }()
    
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
        setupConstraints()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        searchBar.delegate = self
        container.backgroundColor = .white
        clearButton.backgroundColor = .lightGray
        clearButton.setTitle("CLEAR", for:. normal)
        clearButton.setTitleColor(.darkGray, for: .normal)
        lable.text = "RECENT SEARCHES"
        lable.textColor = .black
        tableView.backgroundColor = customColor
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchButton.setBackgroundImage(UIImage(named: "search"), for: .normal) // Set the button's background image
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.setBackgroundImage(UIImage(named: "back"), for: .normal) // Set the button's background image
        
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
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

    }
    
    @objc func searchButtonTapped() {
        if let searchText = searchBar.text, !searchText.isEmpty {
            viewModel.addSearchEntry(keyword: searchText)
//            tableView.reloadData()
//            searchBar.text=""
             delegate?.search(word: searchText)
            navigationController?.popViewController(animated: false)
        }
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func clearButtonTapped() {
        viewModel.clearAll()
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
        return viewModel.recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath)
        as? SearchCell
        cell?.searchLable.text=viewModel.recentSearches[indexPath.row]
        cell?.removeSearchButton.isEnabled=true
        cell?.delegate = self
        cell?.index = Int(indexPath.row)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func remove(at:Int) {
        viewModel.removeSearchEntry(at:at)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}







