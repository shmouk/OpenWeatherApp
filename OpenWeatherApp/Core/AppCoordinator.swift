import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Navigation
    var navigationController: UINavigationController
    var window: UIWindow!
    
    // MARK: - Properties
    var didFinish: (() -> Void)?
    
    // MARK: - Lifecycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.window.rootViewController = navigationController
        startWeatherFlow()
    }
    
    func startWeatherFlow() {
        let tabBarCoordinator = MainTabbarCoordinator()
        self.window.rootViewController = tabBarCoordinator
    }
    
    func stop() {
        didFinish?()
    }
}
