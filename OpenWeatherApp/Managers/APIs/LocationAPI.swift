import CoreLocation

class LocationAPI: NSObject {
    static let shared = LocationAPI()
    
    private let manager = CLLocationManager()
    private var singleUpdateCompletion: StringClosure?

    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func getLocation(locationCompletion: StringClosure?) {
        singleUpdateCompletion = locationCompletion
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
}

extension LocationAPI: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        guard let location = locations.last else { return }
        
        resolveLocationName(with: location) { [weak self] locationName in
            self?.singleUpdateCompletion?(locationName)
        }
    }

    private func resolveLocationName(with location: CLLocation, completion: @escaping StringClosure) {
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(location) { placemarks, _ in
            let name = placemarks?.first?.locality ?? "Minsk"
            completion(name)
        }
    }
}

