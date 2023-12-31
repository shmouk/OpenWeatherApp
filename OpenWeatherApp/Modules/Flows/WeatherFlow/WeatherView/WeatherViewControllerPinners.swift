import Foundation
import UIKit

extension WeatherViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            refreshTimeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            refreshTimeLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            refreshTimeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: view.frame.width / 3),
            refreshTimeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            refreshTimeTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            refreshTimeTitleLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),
            refreshTimeTitleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: view.frame.width / 3),
            refreshTimeTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: refreshTimeLabel.bottomAnchor, constant: 12),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: view.frame.width / 3),
            cityLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            timeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: view.frame.width / 3),
            timeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            timeTitleLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            timeTitleLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),
            timeTitleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: view.frame.width / 3),
            timeTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            weatherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: view.frame.size.width * 0.3),
            weatherImageView.heightAnchor.constraint(equalToConstant: view.frame.size.width * 0.3)
        ])
        
        NSLayoutConstraint.activate([
            weatherTitleLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 8),
            weatherTitleLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),
            weatherTitleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: view.frame.width / 3),
            weatherTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: weatherTitleLabel.bottomAnchor, constant: 8),
            weatherLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),
            weatherLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: view.frame.width / 3),
            weatherLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            temperatureTitleLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 8),
            temperatureTitleLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            temperatureTitleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: view.frame.width / 3),
            temperatureTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: temperatureTitleLabel.bottomAnchor, constant: 8),
            temperatureLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            temperatureLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: view.frame.width / 3),
            temperatureLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
        
        NSLayoutConstraint.activate([
            forecastHoursTitleLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 16),
            forecastHoursTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            forecastHoursTitleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: view.frame.width / 3),
            forecastHoursTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            horizontalScrollView.topAnchor.constraint(equalTo: forecastHoursTitleLabel.bottomAnchor, constant: 4),
            horizontalScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            horizontalScrollView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            forecastDaysTitleLabel.topAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor, constant: 8),
            forecastDaysTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            forecastDaysTitleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: view.frame.width / 3),
            forecastDaysTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            verticalScrollView.topAnchor.constraint(equalTo: forecastDaysTitleLabel.bottomAnchor, constant: 4),
            verticalScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
