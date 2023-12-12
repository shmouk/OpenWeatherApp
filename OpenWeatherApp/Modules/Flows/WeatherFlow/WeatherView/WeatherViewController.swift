import UIKit

class WeatherViewController: BaseViewController {
    let viewModel: WeatherViewModel
    
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
    let forecastHoursTitleLabel = InterfaceBuilder.makeLabel(title: .forecastHours, font: .big, textAlignment: .left)
    let horizontalScrollView = InterfaceBuilder.makeScrollView()
    let forecastDaysTitleLabel = InterfaceBuilder.makeLabel(title: .forecastDays, font: .big, textAlignment: .left)
    let verticalScrollView = InterfaceBuilder.makeScrollView()
    let rightBarButtonItem = InterfaceBuilder.makeRightBarButtonItem()
    let leftBarButtonItem = InterfaceBuilder.makeLeftBarButtonItem()
    
    var rightBarButtonTapped: Handler?
    var didDataLoaded: StringClosure?
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
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
        setupResponsibilities()
        bindViewModel()
        clearScrollView()
    }
    
    private func setUI() {
        setSubviews()
        setupConstraints()
    }
    
    private func setSubviews() {
        view.addSubviews(refreshTimeLabel,
                         refreshTimeTitleLabel,
                         cityLabel,
                         timeLabel,
                         timeTitleLabel,
                         weatherLabel,
                         weatherTitleLabel,
                         temperatureLabel,
                         temperatureTitleLabel,
                         weatherImageView,
                         forecastHoursTitleLabel,
                         horizontalScrollView,
                         forecastDaysTitleLabel,
                         verticalScrollView
        )
    }
    
    private func setupResponsibilities() {
        rightBarButtonItem.target = self
        leftBarButtonItem.target = self
        
        rightBarButtonItem.action = #selector(addedTapped)
        leftBarButtonItem.action = #selector(reloadDataTapped)
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func bindViewModel() {
        viewModel.currentWeatherData.bind { [weak self] data in
            guard let self = self else { return }
            
            self.cityLabel.text = data.city
            self.timeLabel.text =  data.list.first?.date.stringValue
            self.weatherLabel.text = data.list.first?.forecast.first?.mainWeather
            self.temperatureLabel.text = data.list.first?.temp
            
            DispatchQueue.main.async {
                let id = data.list.first?.forecast.first?.iconId
                let image = self.viewModel.getImageFromId(id: id)
                self.weatherImageView.image = image
            }
        }
        
        viewModel.firstSixHoursWeatherData.bind { [weak self] data in
            DispatchQueue.main.async {
                self?.setupHorizontalScrollView(data: data.list)
            }
        }
        
        viewModel.uniqueDaysWeatherData.bind { [weak self] data in
            DispatchQueue.main.async {
                self?.setupVerticalScrollView(data: data.list)
            }
        }
        
        viewModel.ellapsedTime.bind { [weak self] string in
            DispatchQueue.main.async {
                self?.refreshTimeLabel.text = string
            }
        }
    }
    
    func clearScrollView() {
        horizontalScrollView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        verticalScrollView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func setupHorizontalScrollView(data: [WeatherModel.Weather]) {
        var previousView: UIView?
        
        data.forEach { item in
            let subview = InterfaceBuilder.makeView()
            let separatorView = InterfaceBuilder.makeSeparatorView()
            let weatherImageView = InterfaceBuilder.makeImageView()
            let tempLabel = InterfaceBuilder.makeLabel(font: .regular)
            let timeLabel = InterfaceBuilder.makeLabel(font: .regular)
            let id = item.forecast.first?.iconId
            let image = viewModel.getImageFromId(id: id)
            
            timeLabel.text = item.date.stringValue
            tempLabel.text = item.temp
            weatherImageView.image = image
            
            subview.addSubviews(separatorView,
                                timeLabel,
                                weatherImageView,
                                tempLabel)
     
            horizontalScrollView.addSubview(subview)
            
            NSLayoutConstraint.activate([
                subview.widthAnchor.constraint(equalTo: horizontalScrollView.widthAnchor, multiplier: 0.33),
                subview.heightAnchor.constraint(equalTo: subview.widthAnchor),
                subview.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor),
                subview.leadingAnchor.constraint(equalTo: previousView?.trailingAnchor ?? horizontalScrollView.leadingAnchor, constant: 0)
            ])
            
            NSLayoutConstraint.activate([
                separatorView.widthAnchor.constraint(equalToConstant: 2),
                separatorView.heightAnchor.constraint(equalTo: subview.heightAnchor),
                separatorView.trailingAnchor.constraint(equalTo: subview.trailingAnchor),
                separatorView.topAnchor.constraint(equalTo: subview.topAnchor)
            ])
            
            NSLayoutConstraint.activate([
                timeLabel.widthAnchor.constraint(equalTo: subview.widthAnchor),
                timeLabel.heightAnchor.constraint(equalTo: subview.heightAnchor, multiplier: 0.25),
                timeLabel.centerXAnchor.constraint(equalTo: subview.centerXAnchor),
                timeLabel.topAnchor.constraint(equalTo: subview.topAnchor,constant: 8)
            ])
            
            NSLayoutConstraint.activate([
                weatherImageView.widthAnchor.constraint(equalTo: subview.widthAnchor, multiplier: 0.5),
                weatherImageView.heightAnchor.constraint(equalTo: subview.heightAnchor, multiplier: 0.5),
                weatherImageView.centerXAnchor.constraint(equalTo: subview.centerXAnchor),
                weatherImageView.centerYAnchor.constraint(equalTo: subview.centerYAnchor)
            ])
            
            NSLayoutConstraint.activate([
                tempLabel.widthAnchor.constraint(equalTo: subview.widthAnchor),
                tempLabel.heightAnchor.constraint(equalTo: subview.heightAnchor, multiplier: 0.25),
                tempLabel.centerXAnchor.constraint(equalTo: subview.centerXAnchor),
                tempLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: -8)
            ])
            
            previousView = subview
        }
        
        if let lastView = previousView {
            NSLayoutConstraint.activate([
                lastView.trailingAnchor.constraint(equalTo: horizontalScrollView.trailingAnchor, constant: 0)
            ])
        }
    }
    
    func setupVerticalScrollView(data: [WeatherModel.Weather]) {
        var previousView: UIView?
        
        data.forEach { item in
            let subview = InterfaceBuilder.makeView()
            let separatorView = InterfaceBuilder.makeSeparatorView()
            let weatherImageView = InterfaceBuilder.makeImageView()
            let tempLabel = InterfaceBuilder.makeLabel(font: .regular, textAlignment: .center)
            let timeLabel = InterfaceBuilder.makeLabel(font: .regular, textAlignment: .center)
            let id = item.forecast.first?.iconId
            let image = viewModel.getImageFromId(id: id)
            
            timeLabel.text = item.date.stringValue
            tempLabel.text = item.temp
            weatherImageView.image = image
            
            subview.addSubviews(separatorView,
                                timeLabel,
                                weatherImageView,
                                tempLabel)
            
            verticalScrollView.addSubview(subview)
            
            NSLayoutConstraint.activate([
                subview.widthAnchor.constraint(equalTo: verticalScrollView.widthAnchor),
                subview.heightAnchor.constraint(equalToConstant: 64),
                subview.centerXAnchor.constraint(equalTo: verticalScrollView.centerXAnchor),
                subview.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? verticalScrollView.topAnchor) //
            ])
            
            NSLayoutConstraint.activate([
                separatorView.widthAnchor.constraint(equalTo: subview.widthAnchor),
                separatorView.heightAnchor.constraint(equalToConstant: 2),
                separatorView.leadingAnchor.constraint(equalTo: subview.leadingAnchor),
                separatorView.topAnchor.constraint(equalTo: subview.bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
                timeLabel.heightAnchor.constraint(equalTo: subview.heightAnchor),
                timeLabel.widthAnchor.constraint(equalTo: subview.widthAnchor, multiplier: 0.2),
                timeLabel.centerYAnchor.constraint(equalTo: subview.centerYAnchor),
                timeLabel.leadingAnchor.constraint(equalTo: subview.leadingAnchor, constant: 24)
            ])
            
            NSLayoutConstraint.activate([
                weatherImageView.widthAnchor.constraint(equalTo: subview.heightAnchor),
                weatherImageView.heightAnchor.constraint(equalTo: subview.heightAnchor),
                weatherImageView.centerYAnchor.constraint(equalTo: subview.centerYAnchor),
                weatherImageView.centerXAnchor.constraint(equalTo: subview.centerXAnchor)
            ])
            
            NSLayoutConstraint.activate([
                tempLabel.widthAnchor.constraint(equalTo: subview.widthAnchor, multiplier: 0.2),
                tempLabel.heightAnchor.constraint(equalTo: subview.heightAnchor),
                tempLabel.centerYAnchor.constraint(equalTo: subview.centerYAnchor),
                tempLabel.trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: -24)
            ])
            
            previousView = subview
        }
        
        if let lastView = previousView {
            NSLayoutConstraint.activate([
                lastView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor)
            ])
        }
    }
}

private extension WeatherViewController {
    @objc
    private func addedTapped() {
        rightBarButtonTapped?()
    }
    
    @objc
    private func reloadDataTapped() {
        pickData()
    }
    
    func pickData() {
        clearScrollView()
        viewModel.sendRequest(completion: didDataLoaded)
    }
}

