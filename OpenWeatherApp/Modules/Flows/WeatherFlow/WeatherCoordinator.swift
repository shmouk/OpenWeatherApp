import UIKit

final class WeatherCoordinator: TabBarPresentableCoorinator {
    let alertManager = AlertManager.shared
    
    var tabBarItem: UITabBarItem = {
        return UITabBarItem()
    }()
    
    var navigationController: UINavigationController
    
    var didFinish: (() -> Void)?
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
        self.navigationController.navigationBar.isHidden = false
    }
    
    func start() {
        let onboardingController = createOnboardingViewController()
        onboardingController.modalPresentationStyle = .fullScreen
        
        let weatherController = createWeatherController { text in
            DispatchQueue.main.async {
                onboardingController.dismiss(animated: false, completion: nil)
                self.alertManager.showAlert(title: text, viewController: self.navigationController.topViewController)
            }
        }
        
        self.navigationController.pushViewController(weatherController, animated: false)
        
        DispatchQueue.main.async {
            self.navigationController.present(onboardingController, animated: false, completion: nil)
        }
    }
    
    func stop() {
        didFinish?()
    }
}

extension WeatherCoordinator {
    private func createWeatherController(completion: @escaping StringClosure) -> UIViewController {
        let viewModel = WeatherViewModel()
        let controller = WeatherViewController(viewModel: viewModel)
        
        controller.didDataLoaded = { text in
            completion(text)
        }
        
        controller.rightBarButtonTapped = { [weak self] in
            self?.alertManager.showAlertWithTextField(title: TitleForUI.preferredCity.text, viewController: controller, completion: { cityName in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    guard let viewController = self?.createRequestedWeatherViewController(cityName: cityName) else { return }
                    controller.present(viewController, animated: true)
                }
            })
        }
        
        return controller
    }
    
    private func createRequestedWeatherViewController(cityName: String) -> UIViewController {
        let viewModel = WeatherViewModel()
        let controller = RequestedWeatherViewController(viewModel: viewModel, cityName: cityName)
        
        controller.didDataLoaded = { [weak self] text in
            self?.alertManager.showAlert(title: text, viewController: controller)
        }
        
        return controller
    }
    
    private func createOnboardingViewController() -> UIViewController {
        OnboardingViewController()
    }
}
