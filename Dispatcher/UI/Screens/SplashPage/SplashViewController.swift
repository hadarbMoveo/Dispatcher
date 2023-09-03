import UIKit
import FirebaseAuth

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delaySplash()
    }
    
    func delaySplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if (self.isAutomaticLogin()) {
                let storyboardIdentifier = "Main"
                let tabBarControllerIdentifier = "TabBarController"
                let storyboard = UIStoryboard(name: storyboardIdentifier, bundle: nil)
                let tabBarController = storyboard.instantiateViewController(withIdentifier: tabBarControllerIdentifier) as! UITabBarController
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: false, completion: nil)
            }else{
                self.navigationController?.pushViewController(SignUpPageViewController(), animated: false)
            }
        }
    }
    
    func isAutomaticLogin() -> Bool {
        let defaults = UserDefaults.standard
        
        if let savedEmail = defaults.string(forKey: "email"),
           let savedPassword = defaults.string(forKey: "password") {
            return true
        }
        return false
    }
}
    
