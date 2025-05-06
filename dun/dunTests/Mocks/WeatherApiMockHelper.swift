//
//  WeatherApiMockHelper.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/06.
//

import Foundation

class WeatherApiMockHelper: Mockable, DunApiProtocol {
    
    var invokeSuccess = false
    var invokeFailure = false
    var invokeError = false
    
    private static func fetchJsonData(in file: String) throws -> Data {
        let path = Bundle(for: self).path(forResource: file, ofType: "json")
        return try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
    }
    
    static func fetchAndUnbox<T: Decodable>(in file: String) -> T {
        do {
            let data = try WeatherApiMockHelper.fetchJsonData(in: file)
            let details: T = try JSONDecoder().decode(T.self, from: data)
            return details
        } catch {
            fatalError("Cannot convert json file for testing")
        }
    }
    
    static func returnAstronomyResponse() -> WeatherAstronomyResponseModel? {
        return WeatherApiMockHelper.fetchAndUnbox(in: "AstronomyResponse")
    }
    
    static func returnWeatherResponse() -> WeatherResponseModel? {
        return WeatherApiMockHelper.fetchAndUnbox(in: "WeatherResponse")
    }
    
    static func returnWeatherApiErrorResponse() -> WeatherErrorDetails? {
        return WeatherApiMockHelper.fetchAndUnbox(in: "ApiError")
    }
    
    func triggerAsyncRequest<T: Decodable>() async throws -> T {
        let endpoint = WeatherEndpoints.getAstronomy
        
        do {
            return try await asyncRequest(endpoint: endpoint, responseModel: WeatherAstronomyResponseModel.self) as! T
        } catch _ as WeatherErrorDetails {
            return WeatherApiMockHelper.returnWeatherApiErrorResponse() as! T
        }
    }
    
    func asyncRequest<T>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T where T : Decodable {
        if invokeSuccess {
            return WeatherApiMockHelper.returnAstronomyResponse() as! T
        } else if invokeFailure {
            return WeatherApiMockHelper.returnWeatherResponse() as! T
        } else {
            return WeatherApiMockHelper.returnWeatherApiErrorResponse() as! T
        }
    }
    
    func reset() {
        invokeSuccess = false
        invokeFailure = false
        invokeError = false
    }
}

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }

        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(type, from: data)

            return decodedObject
        } catch {
            fatalError("Failed to decode loaded JSON")
        }
    }
}
