//
//  AuthPageViewController.swift
//  Dispatcher
//
//  Created by Hadar Basson on 29/08/2023.
//

import UIKit
import SwiftUI

class SignUpPageViewController: UIViewController {
    
    var viewModel: SignUpPageViewModel  = SignUpPageViewModel(authRepository: AuthFireBaseRepository())
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        let viewz = UIHostingController(rootView:AuthView(viewModel: viewModel,loginButtonTapped:navigateToLogInViewController,moveToTabBar:navigateToTabBarController))
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
        let logInViewController = LogInPageViewController() // Instantiate your LogInViewController
        navigationController?.pushViewController(logInViewController, animated: false)
    }
    
    func navigateToTabBarController(){
        let storyboard = UIStoryboard(name: Strings.storyboardIdentifier, bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: Strings.tabBarControllerIdentifier) as! UITabBarController
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: false, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
