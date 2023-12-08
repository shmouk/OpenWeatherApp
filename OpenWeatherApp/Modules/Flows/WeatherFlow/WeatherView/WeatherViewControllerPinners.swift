import Foundation
import UIKit

extension WeatherViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            refreshTimeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            refreshTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            refreshTimeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            refreshTimeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: refreshTimeLabel.bottomAnchor, constant: 8),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            cityLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            timeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            weatherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            weatherImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
        ])
        
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 8),
            weatherLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            weatherLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            weatherLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 8),
            temperatureLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            temperatureLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            horizontalScrollView.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 16),
            horizontalScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            horizontalScrollView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            verticalScrollView.topAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor, constant: 2),
            verticalScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
