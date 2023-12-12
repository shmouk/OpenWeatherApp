import UIKit

class RequestedWeatherViewController: BaseViewController {
    let viewModel: WeatherViewModel
    let cityName: String
    
    let refreshTimeLabel = InterfaceBuilder.makeLabel(title: .undefined, font: .small)
    let refreshTimeTitleLabel = InterfaceBuilder.makeLabel(title: .lastRequest, font: .small)
    let cityLabel = InterfaceBuilder.makeLabel(title: .undefined, font: .big)
    let timeLabel = InterfaceBuilder.makeLabel(title: .undefined, font: .big)
    let timeTitleLabel = InterfaceBuilder.makeLabel(title: .time, font: .big)
    let weatherLabel = InterfaceBuilder.makeLabel(title: .undefined, font: .big)
    let weatherTitleLabel = InterfaceBuilder.makeLabel(title: .weather, font: .big)
    let temperatureLabel = InterfaceBuilder.makeLabel(title: .undefined, font: .big)
    let temperatureTitleLabel = InterfaceBuilder.makeLabel(title: .temperature, font: .big)
    let weatherImageView = InterfaceBuilder.makeImageView()
    
    var didDataLoaded: StringClosure?
    
    init(viewModel: WeatherViewModel, cityName: String) {
        self.viewModel = viewModel
        self.cityName = cityName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        pickData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindViewModel()
    }
    
    private func setUI() {
        setSubviews()
        setupConstraints()
    }
    
    private func setSubviews() {
        view.addSubviews(cityLabel,
                         timeLabel,
                         timeTitleLabel,
                         weatherLabel,
                         weatherTitleLabel,
                         temperatureLabel,
                         temperatureTitleLabel,
                         weatherImageView
        )
    }
    
    func pickData() {
        viewModel.sendRequest(locationName: cityName, completion: didDataLoaded)
    }
    
    func bindViewModel() {
        viewModel.currentWeatherData.bind { [weak self] data in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.cityLabel.text = data.city
                self.timeLabel.text = data.list.first?.date.stringValue
                self.weatherLabel.text = data.list.first?.forecast.first?.mainWeather
                self.temperatureLabel.text = data.list.first?.temp
                
                let id = data.list.first?.forecast.first?.iconId
                let image = self.viewModel.getImageFromId(id: id)
                self.weatherImageView.image = image
            }
        }
    }
}


