//
//  BaseActivityView.swift
//  Dispatcher
//
//  Created by Hadar Basson on 22/08/2023.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, HeaderDelegate {
    
    let navigationBar = NavigationBar()
    
    var isSearchHidden: Bool {
        return true
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        var activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var backgroundView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0.7
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpConstraints()
    }
    
    func setUpUI(){
        initNavigationBar()
        view.addSubview(backgroundView)
        backgroundView.addSubview(activityIndicator)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
    }    
    
    func initNavigationBar() {
        navigationBar.delegate = self
        navigationBar.setupNavigationBar(for: self)
        navigationBar.searchButton.isHidden = isSearchHidden
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.backgroundView.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.backgroundView.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }

    func alertButtonTapped() {
        print("Alert button tapped")
    }
    
    func searchButtonTapped() {
        print("Search button tapped")
    }
}
