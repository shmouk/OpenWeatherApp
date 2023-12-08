import UIKit
enum RequestError: Error {
    case noData
    case invalidRequest
    case invalidJson
    case emptyFields
    
    var info: String {
        switch self {

        case .emptyFields:
            return "emptyFields".localized
            
        case .noData:
            return "noData".localized
            
        case .invalidRequest:
            return "invalidRequest".localized
            
        case .invalidJson:
            return "invalidJson".localized
        }
    }
}

enum RequestComplete {
    case successLoadData
    
    var info: String {
        switch self {
            
        case .successLoadData:
            return "successLoadData".localized
        }
    }
}

enum TitleForUI {
    case undefined

    var text: String {
        switch self {
            
        case .undefined:
            "undefined"
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
