import Foundation
import Alamofire

public extension RequestBuilder {
    func asURLRequest() throws -> URLRequest {
        var urlRequest = try URLRequest(url: baseURL.appendingPathComponent(path),
                                        method: self.method,
                                        headers: self.headers)
        urlRequest.httpBody = self.body
        urlRequest.allHTTPHeaderFields = self.headers
//        urlRequest = method == .post ? try URLEncoding(destination: .queryString).encode(urlRequest, with: queryParameters) : try URLEncoding.default.encode(urlRequest, with: queryParameters)
//        urlRequest.timeoutInterval = 3
        print(urlRequest)
        return urlRequest
    }
}



 final class CurveResponse {



    let minutes: Double
    let last: Double
    let buy: Double
    let sell: Double
    let symbols: String

    init(dictionary: [String: Any]) {
        self.minutes = dictionary["15m"] as? Double ?? 0
        self.last = dictionary["last"] as? Double ?? 0
        self.buy = dictionary["buy"] as? Double ?? 0
        self.sell = dictionary["sell"] as? Double ?? 0
        self.symbols = dictionary["symbols"] as? String ?? ""
    }

//    enum CodingKeys: String, CodingKey {
//        case minutes = "15m"
//        case last
//        case buy
//        case sell
//        case symbols
//    }
}

public final class NetworkManager {
    public static let shared = NetworkManager()

    public static let successResponseCodes =  Array(200..<300)
    public static let anyResponseCodes = Array(0..<600)

    public func request(requestBuilder: RequestBuilder,
                                      onSuccess: @escaping ([String: Any]) -> Void,
                                      onError: @escaping (Error) -> Void) {

        Alamofire.request(requestBuilder).validate().responseData(completionHandler: { [unowned self] (response) in
            switch response.result {
            case .success(let value):
                do {
                    let dict =  try? JSONSerialization.jsonObject(with: value, options: []) as! [String: Any]
                    let usd = dict!["USD"]
                //let result = try JSONDecoder().decode(T.self, from: dict[0])
                    onSuccess(usd as! [String : Any])
                } catch let error {
                    onError(self.mapError(error))

                }
            case .failure(let error):
                onError(self.mapError(error))
            }
        })

    }

    private func mapError(_ error: Error) -> NetworkError {
        switch error {
        case let error as AFError:
            return .alamofireError(error)
        case let error as URLError:
            return .urlError(error)
        case let error as DecodingError:
            return .decodingError(error)
        default:
            return .unknown(error)
        }
    }
}

