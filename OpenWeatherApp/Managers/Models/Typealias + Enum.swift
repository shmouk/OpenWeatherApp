import UIKit

typealias Handler = (() -> Void)
typealias StringClosure = ((String) -> Void)
typealias CheckClosure = ((String, Bool) -> Void)
typealias RequestResult = Result<RequestSuccess, Error>
typealias ResultClosure = (Result<RequestSuccess, Error>) -> Void
typealias WeatherResult = (Result<WeatherData, Error>) -> Void
typealias WeatherCompletion = (WeatherModel) -> Void
typealias WeatherListCompletion = (([WeatherModel.Weather]) -> Void)
typealias WeatherForecastCompletion = (([WeatherModel.Weather.Forecast]) -> Void)
typealias ImageCompletion = (UIImage) -> Void

enum RequestError: Error {
    case invalidRequest
    case invalidJson
    case imvalidData

    var info: String {
        switch self {
            
        case .invalidRequest:
            "invalidRequest".localized
            
        case .invalidJson:
            "invalidJson".localized
            
        case .imvalidData:
            "imvalidData".localized

        }
    }
}

enum RequestSuccess {
    case successLoadData
    
    var info: String {
        switch self {
            
        case .successLoadData:
            "successLoadData".localized
        }
    }
}

enum IconForUI {
    case add
    case reload
    case weatherIcon

    var image: UIImage? {
        switch self {
       
        case .add:
            UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
        case .reload:
            UIImage(systemName: "arrow.clockwise")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
        case .weatherIcon:
            UIImage(named: "MainIcon")
        }
    }
}

enum TitleForUI {
    case undefined
    case lastRequest
    case time
    case weather
    case temperature
    case forecastDays
    case forecastHours
    case message
    case placeholder
    case alert
    case cancel
    case confirm
    case preferredCity
    
    var text: String {
        switch self {
            
        case .undefined:
            "undefined"
            
        case .lastRequest:
            "lastRequest".localized + ": "
            
        case .time:
            "time".localized + ": "
            
        case .weather:
            "weather".localized + ": "
            
        case .temperature:
            "temperature".localized + ": "
            
        case .forecastDays:
            "forecastDays".localized + ": "
            
        case .forecastHours:
            "forecastHours".localized + ": "
            
        case .message:
            "message".localized
            
        case .placeholder:
            "placeholder".localized
            
        case .alert:
            "alert".localized
            
        case .cancel:
            "cancel".localized
            
        case .confirm:
            "confirm".localized
            
        case .preferredCity:
            "preferredCity".localized
        }
    }
}

enum FontForUI {
    case regular
    case small
    case big
    
    var size: UIFont {
        switch self {
            
        case .regular:
            UIFont.systemFont(ofSize: 17.0)
            
        case .small:
            UIFont.systemFont(ofSize: 14.0)
            
        case .big:
            UIFont.systemFont(ofSize: 20.0)
        }
    }
}
