import Foundation
import Alamofire

public protocol RequestBuilder: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var baseURL: URL { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var queryParameters: [String: Any]? { get }
}

public extension RequestBuilder {
    var method: HTTPMethod {
        return .get
    }
    var baseURL: URL {
        return URL(string: "http://blockchain.info")!
    }
    var headers: [String: String]? {
        return body != nil ? ["Content-Type": "application/json"] : nil
    }
    var body: Data? {
        return nil
    }
    var queryParameters: [String: Any]? {
        return nil
    }
}

