//
//  Networking.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import Foundation
import Combine

public enum RequestMethod: String {
    case get = "GET"
    /// [Sizwe K.]: Would add more but only this is required currently (avoiding unneecessary future proof)
}

struct Password: Encodable {
    let password: String
}

extension Encodable {

    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

public protocol DunApiProtocol {

    func asyncRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T
}

open class DunApiClient: DunApiProtocol {
    
    public init() {}
   
    public var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        return URLSession(configuration: configuration)
    }
    
    public func asyncRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T {
        do {
            let (data, response) = try await session.data(for: endpoint.asURLRequest())
            print("Response: \(response)")
            
            let resp = String(data: data, encoding: String.Encoding(rawValue: NSUTF8StringEncoding))
            
            print("Response Data: \(String(describing: resp))")
            // TODO: Update to remove escaping characters
            return try self.manageResponse(data: data, response: response)
        } catch let error as WeatherErrorDetails {
            throw error
        } catch {
            throw WeatherError(
                errorCode: 0,
                errorDescription: "Unknown API error \(error.localizedDescription)".uppercased()
            )
        }
    }
    
    func manageResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw WeatherError(
                errorCode: 0,
                errorDescription: "Invalid HTTP response"
            )
        }
        switch response.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("‼️", error)
                throw WeatherError(
                    errorCode: 0,
                    errorDescription: "Error decoding data"
                )
            }
        case 400...403:
            if let decodedError = try? JSONDecoder().decode(WeatherErrorDetails.self, from: data) {
                throw WeatherErrorDetails(weatherError: WeatherError(
                    statusCode: response.statusCode,
                    errorCode: decodedError.weatherError.errorCode,
                    errorDescription: "Status Code 4XXX \n Error-\(decodedError.weatherError.errorDescription)".uppercased()
                ))
            } else {
                throw WeatherError(
                    statusCode: response.statusCode,
                    errorCode: 00000,
                    errorDescription: "Unknown backend error".uppercased()
                )
            }
        default:
            guard let decodedError = try? JSONDecoder().decode(WeatherErrorDetails.self, from: data) else {
                throw WeatherError(
                    statusCode: response.statusCode,
                    errorCode: 0000,
                    errorDescription: "Unknown backend error".uppercased()
                )
            }
            
            throw WeatherError(
                statusCode: response.statusCode,
                errorCode: response.statusCode,
                errorDescription: decodedError.weatherError.errorDescription.uppercased()
            )
        }
        /// Above available on https://www.weatherapi.com/docs/#intro-request
    }
}

extension DunApiClient {
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
