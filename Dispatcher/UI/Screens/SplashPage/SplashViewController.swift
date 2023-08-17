import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delaySplash()
    }
    
    func delaySplash() {
        let tabBarIdentifier = "TabBarController"
        let storyboardName = "Main"
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: tabBarIdentifier) as! UITabBarController
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: false, completion: nil)
        }
    }
}

