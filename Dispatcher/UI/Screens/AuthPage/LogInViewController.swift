//
//  LogInViewController.swift
//  Dispatcher
//
//  Created by Hadar Basson on 31/08/2023.
//

import Foundation

import UIKit
import SwiftUI

class LogInPageViewController: UIViewController {
    
    var viewModel: LoginPageViewModel  = LoginPageViewModel(authRepository: AuthFireBaseRepository())
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        let viewz = UIHostingController(rootView: AuthView(viewModel: viewModel,loginButtonTapped:navigateToLogInViewController))
        viewz.view?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(viewz.view)
        
        NSLayoutConstraint.activate([
            viewz.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewz.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewz.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewz.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func navigateToLogInViewController() {
        print("from login")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
