//
//  LaunchScreenViewController.swift
//  Dispatcher
//
//  Created by Hadar Basson on 11/08/2023.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
               // This closure will be executed after 3 seconds
               
               // Replace "YourNavControllerIdentifier" with the actual identifier of the navigation controller you want to transition to
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let navigationController = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
               navigationController.modalPresentationStyle = .fullScreen
               self.present(navigationController, animated: true, completion: nil)
           }
        // Do any additional setup after loading the view.
    }


}
