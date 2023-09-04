import UIKit

class UserPageViewController: BaseViewController {
    
    let viewModel: UserPageViewModel = UserPageViewModel(repository: AuthFireBaseRepository())
    
    @IBOutlet weak var logOutButton: UIButton!


    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logOutButtonTapped(_ sender: Any) {
        Task{
            let logOutSucceeded = await viewModel.logout()
            if logOutSucceeded{
                LogOutToAuthPage()
            }
            else {
                print ("logout failed")
            }
        }
        
    }
        
    func LogOutToAuthPage() {
        
        let storyboardIdentifier = "Main"
        let navControllerIdentifier = "AuthNavController"
        
        let storyboard = UIStoryboard(name: storyboardIdentifier, bundle: nil)
        let navController = storyboard.instantiateViewController(withIdentifier: navControllerIdentifier) as! UINavigationController
        navController.pushViewController(SignUpPageViewController(), animated: false)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: false, completion: nil)
    }
    
    


}
