import UIKit

class SplashViewController: UIViewController {
    
    static var tabBarIdentifier = "TabBarController"
    static var storyboardName = "Main"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let storyboard = UIStoryboard(name: SplashViewController.storyboardName, bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: SplashViewController.tabBarIdentifier) as! UITabBarController
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: false, completion: nil)
        }
    }
}

