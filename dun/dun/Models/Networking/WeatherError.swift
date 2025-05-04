//
//  ApiError.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import Foundation

struct WeatherErrorDetails: Error, Decodable {
    var weatherError: WeatherError
    
    init(weatherError: WeatherError) {
        self.weatherError = weatherError
    }
    
    enum CodingKeys: String, CodingKey {
        case errorObj = "error"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        weatherError = try container.decode(WeatherError.self, forKey: .errorObj)
    }
}

struct WeatherError: Error, Decodable {

    var statusCode: Int!
    var errorCode: Int
    var errorDescription: String
    
    init(statusCode: Int = 0, errorCode: Int, errorDescription: String) {
        self.statusCode = statusCode
        self.errorCode = errorCode
        self.errorDescription = errorDescription
    }
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "code"
        case errorDescription = "message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try container.decode(Int.self, forKey: .errorCode)
        errorDescription = try container.decode(String.self, forKey: .errorDescription).uppercased()
    }
}
