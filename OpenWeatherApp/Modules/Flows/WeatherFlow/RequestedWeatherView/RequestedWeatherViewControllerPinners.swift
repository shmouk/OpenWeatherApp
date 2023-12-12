import Foundation
import UIKit

extension RequestedWeatherViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
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
    }
}
