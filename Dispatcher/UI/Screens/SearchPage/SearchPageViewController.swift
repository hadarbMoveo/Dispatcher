//
//  SearchPageViewController.swift
//  Dispatcher
//
//  Created by Hadar Basson on 22/08/2023.
//

import UIKit

class SearchPageViewController: BaseViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, SearchDelegate {
    
    let viewModel: SearchPageViewModel = SearchPageViewModel()
    weak var delegate: HomePageDelegate?

    let vcView = SearchPageView()
    override func loadView() {
        self.view = vcView
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
        vcView.searchBar.delegate = self
        vcView.tableView.dataSource = self
        vcView.tableView.delegate = self
        vcView.tableView.register(UINib(nibName:String(describing: SearchCell.self), bundle: nil), forCellReuseIdentifier: SearchCell.identifier)
        setTargets()
    }
    
    
    func setTargets(){
        vcView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        vcView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        vcView.clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - UI Setup
    
    func search(word: String) {
        delegate?.search(word: word)
        navigationController?.popViewController(animated: false)
    }
    
    @objc
    override func searchButtonTapped() {
        if let searchText = vcView.searchBar.text, !searchText.isEmpty {
            viewModel.addSearchEntry(keyword: searchText)
            search(word: searchText)
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func clearButtonTapped() {
        viewModel.clearAll()
        DispatchQueue.main.async {
            self.vcView.tableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchSelected = viewModel.recentSearches[indexPath.row]
        search(word: searchSelected)
    }
    
    func remove(at:Int) {
        viewModel.removeSearchEntry(at:at)
        DispatchQueue.main.async {
            self.vcView.tableView.reloadData()
        }
    }
}







