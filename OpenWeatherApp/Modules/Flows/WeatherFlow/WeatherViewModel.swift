import Foundation
import UIKit

class WeatherViewModel {
    let weatherAPI = WeatherAPI.shared
    let locationAPI = LocationAPI.shared
    let timerManager = TimerManager.shared

    let currentWeatherData = Bindable(WeatherModel.mock)
    let firstSixHoursWeatherData = Bindable(WeatherModel.mock)
    let uniqueDaysWeatherData = Bindable(WeatherModel.mock)
    let ellapsedTime = Bindable(String())

    func sendRequest(locationName: String? = nil, completion: StringClosure?) {
        guard let requestLocation = locationName else {
            getLocationAndForecast(completion: completion)
            return
        }
        
        getForecast(locationName: requestLocation, saveIsNedeed: false) { [weak self] result in
            self?.processForecastResult(result, completion: completion)
        }
    }

    private func getLocationAndForecast(completion: StringClosure?) {
        locationAPI.getLocation { [weak self] responseLocation in
            self?.getForecast(locationName: responseLocation) { [weak self] result in
                self?.startCountDown()
                self?.processForecastResult(result, completion: completion)
            }
        }
    }

    private func processForecastResult(_ result: RequestResult, completion: StringClosure?) {
        switch result {
            case .success(let response):
                completion?(response.info)
            
            case .failure(let error):
                takeDataFromStorage()
                completion?(error.localizedDescription)
        }
    }
   
  
    private func getForecast(locationName: String, saveIsNedeed: Bool = true, completion: @escaping ResultClosure) {
        weatherAPI.sendRequest(locationName, .forecast, saveIsNedeed) { [weak self] result in
            switch result {
            case .success(let data):
                self?.currentWeatherData.value = data.currentWeather
                self?.firstSixHoursWeatherData.value = data.firstSixHours
                self?.uniqueDaysWeatherData.value = data.uniqueDays
                completion(.success(.successLoadData))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getImageFromId(id: String?) -> UIImage {
       weatherAPI.loadImageFromURL(iconString: id)
    }
    
    private func startCountDown() {
        timerManager.stopTimer()
        timerManager.startTimer(target: self, selector: #selector(handleTimer))
    }
    
    private func takeDataFromStorage() {
        guard let data = weatherAPI.returnDataFromStorage() else { return }
        currentWeatherData.value = data.currentWeather
        firstSixHoursWeatherData.value = data.firstSixHours
        uniqueDaysWeatherData.value = data.uniqueDays
    }
}

private extension WeatherViewModel {
    @objc
    func handleTimer() {
        getEllapsedTime(fromDate: currentWeatherData.value.responseTime)
    }
    
    func getEllapsedTime(fromDate: Int) {
        let time = DateManagers.formatTimeInterval(from: fromDate)
        ellapsedTime.value = time
    }
}
