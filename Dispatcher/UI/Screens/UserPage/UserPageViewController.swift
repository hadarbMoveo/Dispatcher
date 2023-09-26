import UIKit

class UserPageViewController: BaseViewController {
    
    let viewModel: UserPageViewModel = UserPageViewModel(repository: AuthRepository())
    
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
        self.dismiss(animated: false)
        self.navigationController?.pushViewController(SignUpPageViewController(), animated: false)
    }
}
