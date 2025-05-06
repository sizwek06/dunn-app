//
//  WeatherAstronomyResponseModel.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import Foundation

// MARK: - WeatherSunResponse
public struct WeatherAstronomyResponseModel: Codable {
    let astronomy: Astronomy
}

// MARK: - Astronomy
public struct Astronomy: Codable {
    let astro: Astro
}

// MARK: - Astro
public struct Astro: Codable {
    let sunrise, sunset: String

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset
    }
}
