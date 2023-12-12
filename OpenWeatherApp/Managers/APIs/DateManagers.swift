import Foundation

extension DateManagers {
    enum TimeUnits: Int {
        case seconds = 1
        case minutes = 60
        case hours = 3600
        case days = 86400

        var localizedString: String {
            switch self {
            case .seconds:
                "seconds".localized
                
            case .minutes:
                "minutes".localized
                
            case .hours:
                "hours".localized
                
            case .days:
                "days".localized
            }
        }
    }
}

extension DateManagers {
    enum DateFormat: String {
        case dayMonthHours = "d MMMM HH:mm"
        case dayMonth = "dd.MM"
        case hours = "HH:mm"
    }
}

final class DateManagers {
    static func formatDate(unixTimestamp: Int?, dateFormat: DateFormat) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp ?? Constants.emptyInt)) 
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = dateFormat.rawValue

        return dateFormatter.string(from: date)
    }
    
    static func getCurrentTime() -> Int {
        Int(Date().timeIntervalSince1970)
    }
    
    static func formatTimeInterval(from timestamp: Int) -> String {
        let currentTime = Int(Date().timeIntervalSince1970)
        let elapsedTime = currentTime - timestamp
        let timeUnit: TimeUnits

        switch elapsedTime {
        case ..<TimeUnits.minutes.rawValue:
            timeUnit = .seconds
            
        case ..<TimeUnits.hours.rawValue:
            timeUnit = .minutes
            
        case ..<TimeUnits.days.rawValue:
            timeUnit = .hours
            
        default:
            timeUnit = .days
        }

        let value: Int
        switch timeUnit {
        case .seconds:
            value = elapsedTime
        case .minutes:
            value = elapsedTime / TimeUnits.minutes.rawValue
            
        case .hours:
            value = elapsedTime / TimeUnits.hours.rawValue
            
        case .days:
            value = elapsedTime / TimeUnits.days.rawValue
        }

        return "\(value) \(timeUnit.localizedString)"
    }
}

