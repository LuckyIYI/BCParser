import Alamofire

public enum NetworkError: LocalizedError {
    case alamofireError(AFError)
    case urlError(URLError)
    case decodingError(DecodingError)
    case unknown(Error)

    public var errorDescription: String? {
        switch self {
        case .alamofireError(let error):
            return "Alamofire Error: " + error.localizedDescription
        case .urlError(let error):
            return "URL Error: " + error.localizedDescription
        case .decodingError(let error):
            return "Decoding Error: " + error.localizedDescription
        case .unknown(let error):
            return "Unknown Error: " + error.localizedDescription
        }
    }
}

