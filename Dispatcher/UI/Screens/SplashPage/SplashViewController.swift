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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.navigationController?.pushViewController(SignUpPageViewController(), animated: false)

        }
    }
}

