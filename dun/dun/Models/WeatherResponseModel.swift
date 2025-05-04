//
//  WeatherResponseModel.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import Foundation
// TODO: Add initializaers
// MARK: - WeatherResponseModel
public struct WeatherResponseModel: Codable {
    let location: CurrentLocation
    let current: Current
}

// MARK: - Current
public struct Current: Codable {
    let tempC: Double
    let isDay: Int
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
    }
}

// MARK: - Condition
public struct Condition: Codable {
    let text, icon: String
    let code: Int
}

// MARK: - Location
public struct CurrentLocation: Codable {
    let name, region, country: String
    let lat, lon: Double

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
    }
}
