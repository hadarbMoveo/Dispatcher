//
//  FavoritePageView.swift
//  Dispatcher
//
//  Created by Hadar Basson on 04/09/2023.
//

import UIKit

class FavoritePageView: UIView {
    
    
    lazy var title: UILabel = {
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Saved articles"
        title.textColor = .black
        title.font = UIFont.boldSystemFont(ofSize: 28)
        return title
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubview(title)
        addSubview(tableView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            title.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            title.leadingAnchor.constraint(equalTo: trailingAnchor,constant: 16),
            
            tableView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
