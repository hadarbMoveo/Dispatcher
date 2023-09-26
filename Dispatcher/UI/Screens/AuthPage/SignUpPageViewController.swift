//
//  AuthPageViewController.swift
//  Dispatcher
//
//  Created by Hadar Basson on 29/08/2023.
//

import UIKit
import SwiftUI

class SignUpPageViewController: UIViewController {
    
    var viewModel: SignUpPageViewModel  = SignUpPageViewModel(authRepository: AuthRepository())
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.clearInputs()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true

        let authView = AuthView(viewModel: viewModel,changeAuthView: switchViewController,continueToHomePage: navigateToTabBarController)
        let viewSignUpPage = UIHostingController(rootView: authView)
        viewSignUpPage.view?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(viewSignUpPage.view)
        
        NSLayoutConstraint.activate([
            viewSignUpPage.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewSignUpPage.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewSignUpPage.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewSignUpPage.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func switchViewController() {
        self.dismiss(animated: false)
        let logInViewController = LogInPageViewController()
        navigationController?.pushViewController(logInViewController, animated: false)
    }
    
    func navigateToTabBarController() {
        let storyboardIdentifier = "Main"
        let tabBarControllerIdentifier = "TabBarController"
        let storyboard = UIStoryboard(name: storyboardIdentifier, bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: tabBarControllerIdentifier) as! UITabBarController
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: false, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func clearInputs() {
        viewModel.clearInputs()
    }
}
