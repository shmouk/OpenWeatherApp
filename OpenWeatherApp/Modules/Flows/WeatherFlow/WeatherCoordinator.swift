import UIKit

final class WeatherCoordinator: TabBarPresentableCoorinator {
    var tabBarItem: UITabBarItem = {
        let selectedIcon = UIImage(systemName: "play.house.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let unselectedIcon = UIImage(systemName: "play.house.fill")?.withTintColor(UIColor(named: "OtherColor") ?? .black, renderingMode: .alwaysOriginal)
        let item = UITabBarItem()
        item.selectedImage = selectedIcon
        item.image = unselectedIcon
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return item
    }()
    
    var navigationController: UINavigationController
    
    var didFinish: (() -> Void)?
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        self.navigationController.pushViewController(createWeatherController(), animated: false)
    }
    
    func stop() {
        didFinish?()
    }
}

extension WeatherCoordinator {
    private func createWeatherController() -> UIViewController {
        let viewModel = WeatherViewModel()
        let controller = WeatherViewController(viewModel: viewModel)
        
//        controller.didTapLogIn = { [weak self] text in
//            self?.alertManager.showAlert(title: text, viewController: controller)
//        }
//
//        controller.didTapCreateAccount = { [self] in
//            self.navigationController.present(createRegisterController(), animated: true)
//        }
//
//        viewModel.authStateHandler = { [weak self] authState in
//            guard authState else {
//                self?.navigationController.popViewController(animated: true)
//                return
//            }
//            self?.stop()
//        }
//
        return controller
    }
}
