import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "BgColor")
        self.shouldHideTabBar(true)
    }
    
    func shouldHideNavBar(_ status: Bool) {
        if let tabController = self.tabBarController as? MainTabbarCoordinator {
            status ? tabController.hideNavbar(): tabController.showNavbar()
        }
    }
    
    func shouldHideTabBar(_ status: Bool) {
        if let tabController = self.tabBarController as? MainTabbarCoordinator {
            status ? tabController.hideTabbar(): tabController.showTabbar()
        }
    }
}
