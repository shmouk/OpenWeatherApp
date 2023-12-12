import Foundation
import UIKit

extension WeatherAPI {
    enum RequestMethod {
        case weather
        case forecast
        
        var string: String {
            switch self {
                
            case .weather:
                "weather"
                
            case .forecast:
                "forecast"
            }
        }
    }
}

class WeatherAPI {
    static var shared = WeatherAPI()
    private let userDefaultsManager = UserDefaultsManager.shared

    private let apiKey = "6f6fa0b266ccd7c09e73b8a6768305ef"
    private let baseUrl = "api.openweathermap.org/data/2.5/"
    private let units = "metric"
    private let weatherQueue = DispatchQueue(label: "com.weather.queue", attributes: .concurrent)

    private func makeUrl(_ method: RequestMethod, parameters: [URLQueryItem]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.path = baseUrl + method.string
        
        var queryItems = [
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: units),
            URLQueryItem(name: "lang", value: Constants.lang)
        ]
        
        queryItems.append(contentsOf: parameters)
        components.queryItems = queryItems
        return components.url
    }
    
    func sendRequest(_ locationName: String, _ method: RequestMethod, _ saveIsNedeed: Bool = true, completion: @escaping WeatherResult) {
        let parameters = [
            URLQueryItem(name: "q", value: locationName)
        ]
        
        guard let weatherUrl = makeUrl(method, parameters: parameters) else {
            completion(.failure(RequestError.invalidRequest))
            return
        }

        URLSession.shared.dataTask(with: weatherUrl) { [weak self] (data, response, error) in
            guard error == nil, let self = self else {
                completion(.failure(error ?? RequestError.invalidRequest))
                return
            }

            guard let data = data else {
                completion(.failure(RequestError.imvalidData))
                return
            }

            guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                  let jsonDict = json as? [String: Any],
                  !self.catchError(json: jsonDict) else {
                completion(.failure(RequestError.invalidJson))
                return
            }

            self.parse(json: jsonDict) { data in
                let separationData = self.separationData(weatherData: data)
                if saveIsNedeed {
                    self.saveData(separationData)
                }
    
                DispatchQueue.main.async {
                    completion(.success(separationData))
                }
            }
            
        }.resume()
    }
    
    private func catchError(json: [String: Any]) -> Bool {
        guard let message = json["message"] as? String,
              message.contains("city not found") else {
            return false
        }
        return true
    }
    
    private func parse(json: [String: Any], completion: @escaping WeatherCompletion) {
        let list = json["list"] as? [[String: Any]]
        let city = json["city"] as? [String: Any]
        let name = city?["name"] as? String
        let currentTime = DateManagers.getCurrentTime()
        
        weatherQueue.async { [weak self] in
            self?.fetchWeatherObjects(data: list) { data in
                let weatherModel = WeatherModel(city: name, list: data, responseTime: currentTime)
                completion(weatherModel)
            }
        }
    }

    private func fetchWeatherObjects(data: [[String: Any]]?, completion: @escaping WeatherListCompletion) {
        let dispatchGroup = DispatchGroup()
        var weatherObjects: [WeatherModel.Weather] = []

        weatherQueue.async { [weak self] in
            guard let self = self else { return }
            
            dispatchGroup.enter()

            data?.forEach { json in
                dispatchGroup.enter()

                let main = json["main"] as? [String: Any]
                let temp = main?["temp"] as? Double ?? Constants.emptyDouble
                let convertTemp = String(self.celsiusToFahrenheitIfNedeed(temp)) + "°"
                let date = json["dt"] as? Int ?? Constants.emptyInt
                let weather = json["weather"] as? [[String: Any]]
                let dateData = WeatherModel.Weather.DateInfo(intValue: date, stringValue: "")
                
                self.fetchWeatherForecastObjects(data: weather) { data in
                    let weatherModel = WeatherModel.Weather(temp: convertTemp, forecast: data, date: dateData)
                    weatherObjects.append(weatherModel)
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.leave()

            dispatchGroup.notify(queue: .main) {
                completion(weatherObjects)
            }
        }
    }

    private func fetchWeatherForecastObjects(data: [[String: Any]]?, completion: @escaping WeatherForecastCompletion) {
        let dispatchGroup = DispatchGroup()
        var weatherInfoObjects: [WeatherModel.Weather.Forecast] = []

        weatherQueue.async {
            dispatchGroup.enter()
            
            data?.forEach { json in
                let weather = json["main"] as? String ?? Constants.emptyString
                let iconString = json["icon"] as? String ?? Constants.emptyString
                let weatherInfo = WeatherModel.Weather.Forecast(mainWeather: weather, iconId: iconString)
                weatherInfoObjects.append(weatherInfo)
            }
            dispatchGroup.leave()
            
            dispatchGroup.notify(queue: .main) {
                completion(weatherInfoObjects)
            }
        }
    }

    func loadImageFromURL(iconString: String?) -> UIImage {
        let dispatchGroup = DispatchGroup()
        var icon: UIImage?
        
        guard let iconString = iconString,
              let url = URL(string: "https://openweathermap.org/img/wn/\(iconString)@2x.png") else {
            return icon ?? UIImage()
        }
        
        dispatchGroup.enter()
        
        weatherQueue.async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                defer { dispatchGroup.leave() }
                
                guard error == nil, let data = data,
                      let image = UIImage(data: data) else {
                    return
                }
                icon = image
            }.resume()
        }
        
        dispatchGroup.wait()

        return icon ?? UIImage()
    }

    
    func separationData(weatherData: WeatherModel) -> WeatherData {
        let filterFirst = filterForPrefix(1, weatherData)
        let filterFirstSix = filterForPrefix(6, weatherData)
        let uniqueDays = filterUniqueDays(weatherData)
        let data = WeatherData(currentWeather: filterFirst, firstSixHours: filterFirstSix, uniqueDays: uniqueDays)
        return data
    }
    
    private func filterUniqueDays(_ weatherData: WeatherModel) -> WeatherModel {
        let uniqueDays = weatherData.list.reduce(into: [Int: WeatherModel.Weather]()) { unique, weather in
            let timeInterval = TimeInterval(weather.date.intValue)
            let startOfDay = Calendar.current.startOfDay(for: Date(timeIntervalSince1970: timeInterval))
            let timestamp = Int(startOfDay.timeIntervalSince1970)
            unique[timestamp] = weather
        }

        let mappedUniqueList = uniqueDays.map { data in
            let intValue = data.value.date.intValue
            let formattedDate = DateManagers.formatDate(unixTimestamp: intValue, dateFormat: .dayMonth)
            let newValue = WeatherModel.Weather.DateInfo(intValue: intValue, stringValue: formattedDate)
                
            return WeatherModel.Weather(temp: data.value.temp, forecast: data.value.forecast, date: newValue)
        }
        
        let sortedUniqueList = mappedUniqueList.sorted { $0.date.intValue < $1.date.intValue }

        return WeatherModel(city: weatherData.city, list: sortedUniqueList, responseTime: weatherData.responseTime)
    }
    
    private func filterForPrefix(_ prefix: Int, _ weatherData: WeatherModel) -> WeatherModel {
        let firstSixWeather: [WeatherModel.Weather] = weatherData.list.prefix(prefix).map { data in
            let intValue = data.date.intValue
            let formattedDate = DateManagers.formatDate(unixTimestamp: intValue, dateFormat: prefix == 1 ? .dayMonthHours : .hours)
            let newValue = WeatherModel.Weather.DateInfo(intValue: intValue, stringValue: formattedDate)
            
            return WeatherModel.Weather(temp: data.temp, forecast: data.forecast, date: newValue)
        }
        
        return WeatherModel(city: weatherData.city, list: firstSixWeather, responseTime: weatherData.responseTime)
    }
    
    private func saveData(_ data: WeatherData) {
        userDefaultsManager.saveValue(data, forKey: .weatherData)
    }
    
    func returnDataFromStorage() -> WeatherData? {
        userDefaultsManager.getValue(forKey: .weatherData) 
    }
    
    func celsiusToFahrenheitIfNedeed(_ celsius: Double) -> Int {
        let lang = Constants.lang
        let value = lang.contains("EN") ? celsius * 9/5 + 32 : celsius
        return Int(value)
    }
}



