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
    
    var viewModel: LoginPageViewModel = LoginPageViewModel(authRepository: AuthFireBaseRepository())
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        
        let authView = AuthView(viewModel: viewModel,switchViewController: switchViewController,moveToTabBar: navigateToTabBarController)
        let viewLogInPage = UIHostingController(rootView: authView)
        viewLogInPage.view?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(viewLogInPage.view)
        
        NSLayoutConstraint.activate([
            viewLogInPage.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewLogInPage.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewLogInPage.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewLogInPage.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func switchViewController() {
        navigationController?.popViewController(animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func navigateToTabBarController() {
        let storyboard = UIStoryboard(name: Strings.storyboardIdentifier, bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: Strings.tabBarControllerIdentifier) as! UITabBarController
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: false, completion: nil)
    }
}
