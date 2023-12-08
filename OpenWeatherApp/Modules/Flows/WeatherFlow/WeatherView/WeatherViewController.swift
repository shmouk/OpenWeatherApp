import UIKit

class WeatherViewController: BaseViewController {
    let viewModel: WeatherViewModel
    
    let refreshTimeLabel = InterfaceBuilder.makeLabel(title: .undefined, font: .big)
    let cityLabel = InterfaceBuilder.makeLabel(title: .undefined, font: .big)
    let timeLabel = InterfaceBuilder.makeLabel(title: .undefined, font: .big)
    let weatherLabel = InterfaceBuilder.makeLabel(title: .undefined, font: .big)
    let temperatureLabel = InterfaceBuilder.makeLabel(title: .undefined, font: .big)
    let weatherImageView = InterfaceBuilder.makeImageView()
    let horizontalScrollView = InterfaceBuilder.makeScrollView()
    let verticalScrollView = InterfaceBuilder.makeScrollView()
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupResponsibilities()
    }
    
    private func setUI() {
        setSubviews()
        setupConstraints()
    }
    
    private func setSubviews() {
        view.addSubviews(refreshTimeLabel,
                         cityLabel,
                         timeLabel,
                         weatherImageView,
                         weatherLabel,
                         temperatureLabel,
                         horizontalScrollView,
                         verticalScrollView
        )
    }
    
    private func setupResponsibilities() {
    }
}

private extension WeatherViewController {
    @objc
    private func registerTapped() {
        collectData()
    }
    
    private func collectData() {
    
    }
}

