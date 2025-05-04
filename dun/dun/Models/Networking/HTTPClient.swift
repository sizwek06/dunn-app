//
//  HTTPClient.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import Foundation

protocol EndpointProvider {

    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

extension EndpointProvider {

    var scheme: String {
        return "https"
    }

    var baseURL: String {
        return "api.weatherapi.com"
    }

    func asURLRequest() throws -> URLRequest {

        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = baseURL
        urlComponents.path = path
        
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            throw WeatherError(errorCode: 0, errorDescription: "URL error")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("true", forHTTPHeaderField: "X-Use-Cache")
        print("URL request: \(urlRequest)")
        return urlRequest
    }
}

enum WeatherEndpoints: EndpointProvider {

    case getCurrent
    case getAstronomy
    
    var path: String {
        switch self {
        case .getCurrent:
            return "/v1/current.json"
        case .getAstronomy:
            return "/v1/astronomy.json"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getCurrent, .getAstronomy:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getCurrent, .getAstronomy:
            return [URLQueryItem(name: "key",
                                 value: TodoStrings.apiKey as? String),
                    URLQueryItem(name: "q",
                                 value: "\(DunLocationState.sharedInstance.lat),\(DunLocationState.sharedInstance.long)")]
        }
    }
}
