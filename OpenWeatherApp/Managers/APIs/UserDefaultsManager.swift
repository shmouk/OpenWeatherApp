import Foundation

extension UserDefaultsManager {
    enum Keys: String {
        case weatherData = "weatherData"
    }
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard

    private init() { }

    func saveValue<T: Encodable>(_ value: T, forKey key: Keys) {
        do {
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(value)
            defaults.set(encoded, forKey: key.rawValue)
        } catch {
            print("Error encoding object: \(error)")
        }
    }

    func getValue<T: Decodable>(forKey key: Keys) -> T? {
        guard let data = defaults.data(forKey: key.rawValue) else { return nil }
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            print("Error decoding object: \(error)")
            return nil
        }
    }

    func removeData(forKey key: Keys) {
        defaults.removeObject(forKey: key.rawValue)
    }
}

