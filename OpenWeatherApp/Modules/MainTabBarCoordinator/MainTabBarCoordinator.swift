import UIKit

// MARK: - TabBarPresentableCoorinator
protocol TabBarPresentableCoorinator: Coordinator {
    var tabBarItem: UITabBarItem { get }
}

final class MainTabbarCoordinator: UITabBarController {
    
    private var coordinators: [TabBarPresentableCoorinator]!
            
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setUI() {
        self.tabBar.invalidateIntrinsicContentSize()
        self.tabBar.layoutSubviews()
        self.setupTabbarAppearance()
        self.addTabbarShadow()
        self.fillCoordinators()
    }
    
    private func setupTabbarAppearance() {
        UITabBar.appearance().backgroundColor = UIColor(named: "BgColorLight")
    }
    
    private func addTabbarShadow() {
        tabBar.layer.shadowOffset = .zero
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
    }
    
    private func fillCoordinators() {
        let weatherCoordinator = WeatherCoordinator(navigation: UINavigationController())

        coordinators = [weatherCoordinator]

        coordinators.forEach {
            $0.navigationController.tabBarItem = $0.tabBarItem
        }
        
        self.viewControllers = coordinators.map {
            $0.navigationController
        }
        coordinators.forEach { $0.start() }
    }
    
    func hideTabbar() {
        self.tabBar.isHidden = true
    }
    
    func showTabbar() {
        self.tabBar.isHidden = false
    }
    
    func hideNavbar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func showNavbar() {
        self.navigationController?.navigationBar.isHidden = false
    }
}

