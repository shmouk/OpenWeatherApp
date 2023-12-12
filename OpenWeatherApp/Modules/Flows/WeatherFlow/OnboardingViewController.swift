import UIKit

class OnboardingViewController: BaseViewController {
    private let blurView = InterfaceBuilder.makeView(blurIsNeeded: true)
    private let activityIndicator = InterfaceBuilder.makeActivityIndicatorView()
    
    var canCloseHandler: Handler?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBlurView()
        setupActivityIndicator()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityIndicator.stopAnimating()
    }
    
    private func setupBlurView() {
        view.backgroundColor = .clear
        view.addSubview(blurView)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
}
