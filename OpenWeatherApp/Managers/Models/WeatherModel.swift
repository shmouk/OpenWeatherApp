import Foundation
import UIKit

struct WeatherData: Codable {
    let currentWeather: WeatherModel
    let firstSixHours: WeatherModel
    let uniqueDays: WeatherModel
}

struct WeatherModel: Codable {
    let city: String?
    let list: [Weather]
    let responseTime: Int

    struct Weather: Codable {
        let temp: String
        let forecast: [Forecast]
        let date: DateInfo
        
        struct Forecast: Codable {
            let mainWeather: String
            let iconId: String
        }
        
        struct DateInfo: Codable {
            let intValue: Int
            let stringValue: String
        }
    }
}

extension WeatherModel {
    static var mock: WeatherModel = .mock
}

extension WeatherModel.Weather {
    static var mock: WeatherModel.Weather = .mock
}

extension WeatherModel.Weather.Forecast {
    static var mock: WeatherModel.Weather.Forecast = .mock
}

extension WeatherModel.Weather.DateInfo {
    static var mock: WeatherModel.Weather.DateInfo = .mock
}

