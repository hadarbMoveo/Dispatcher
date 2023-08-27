//
//  SearchView.swift
//  Dispatcher
//
//  Created by Hadar Basson on 24/08/2023.
//

import UIKit

class SearchPageView : UIView {
    
    let customColor = UIColor(named: "search-page-color")
    
    lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.searchTextField.backgroundColor = .white
        searchBar.backgroundColor = .white
        searchBar.searchTextField.leftViewMode = .never
        return searchBar
    }()
    
    lazy var recentSearchesView: UIView = {
        var recentSearchesView = UIView()
        recentSearchesView.translatesAutoresizingMaskIntoConstraints = false
        recentSearchesView.backgroundColor = customColor
        return recentSearchesView
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = customColor
        return tableView
    }()
    
    lazy var searchButton: UIButton = {
        var searchButton = UIButton()
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setBackgroundImage(UIImage(named: "search"), for: .normal)
        return searchButton
    }()
    
    lazy var backButton: UIButton = {
        var backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setBackgroundImage(UIImage(named: "back"), for: .normal)
        return backButton
    }()
    
    lazy var container: UIView = {
        var container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        return container
    }()
    
    lazy var lable: UILabel = {
        var lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "RECENT SEARCHES"
        lable.textColor = .black
        return lable
    }()
    
    lazy var clearButton: UIButton = {
        var clearButton = UIButton()
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.backgroundColor = .lightGray
        clearButton.setTitle("CLEAR", for:. normal)
        clearButton.setTitleColor(.darkGray, for: .normal)
        return clearButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        container.addSubview(searchButton)
        container.addSubview(searchBar)
        container.addSubview(backButton)
        addSubview(container)
        recentSearchesView.addSubview(clearButton)
        recentSearchesView.addSubview(lable)
        addSubview(recentSearchesView)
        addSubview(tableView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.heightAnchor.constraint(equalToConstant: 80),
            
            searchBar.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -60),
            searchBar.heightAnchor.constraint(equalToConstant: 80),
            
            searchButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo:container.centerYAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            backButton.centerYAnchor.constraint(equalTo:container.centerYAnchor),
            
            recentSearchesView.topAnchor.constraint(equalTo: container.bottomAnchor),
            recentSearchesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recentSearchesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recentSearchesView.heightAnchor.constraint(equalToConstant: 80), // Adjust height as needed
            
            lable.leadingAnchor.constraint(equalTo: recentSearchesView.leadingAnchor,constant: 10),
            lable.centerYAnchor.constraint(equalTo:recentSearchesView.centerYAnchor),
            
            clearButton.trailingAnchor.constraint(equalTo: recentSearchesView.trailingAnchor,constant: -10),
            clearButton.centerYAnchor.constraint(equalTo:recentSearchesView.centerYAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: 60),
            
            tableView.topAnchor.constraint(equalTo: recentSearchesView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
