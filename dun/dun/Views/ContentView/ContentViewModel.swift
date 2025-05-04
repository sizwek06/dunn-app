//
//  ContentViewModel.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    
    enum ViewState: Equatable {
        case loading
        case weatherReceived
        case errorView(String)
    }
    
    var currentTemp: Double = 0
    var sunRiseTime: String = "12 AM"
    var sunSetTime: String = "12 PM"
    
    var city: String = "Paris"
    var country: String = "France"
    var condition: Condition?
    // TODO: make above struct
    
    var todoViewModel: TodoViewModel?
    var errorViewModel: ErrorViewModel?
    var errorDescription: String?
    var errorCode: String?
    
    @Published var showingError = false
    @Published var state: ViewState = .loading
    
    let locationManager = LocationDataManager()
    let apiClient: DunApiProtocol!
    
    init(apiClient: DunApiProtocol = DunApiClient()) {
        self.apiClient = apiClient
    }
    
    func getAsyncWeather() async {
        
        self.todoViewModel = TodoViewModel()
        self.errorViewModel = ErrorViewModel()
        guard let locationManager = locationManager.locationManager.location else {
            self.state = .errorView("Location not found, please review device settings and restart app.")
            // TODO: Test if the location fails
            return
        }
        
        DunLocationState.sharedInstance.long = locationManager.coordinate.longitude.description
        DunLocationState.sharedInstance.lat = locationManager.coordinate.latitude.description
        
        let endpoint = WeatherEndpoints.getCurrent
        Task {
            do {
                let weather = try await apiClient.asyncRequest(endpoint: endpoint, responseModel: WeatherResponseModel.self)
                
                await MainActor.run {
                    self.todoViewModel?.city = weather.location.name
                    self.todoViewModel?.country = weather.location.country
                    self.todoViewModel?.currentTemp = weather.current.tempC
                    self.todoViewModel?.condition = weather.current.condition
                    
                    self.state = .weatherReceived
                }
            } catch let error as WeatherErrorDetails {
                await MainActor.run {
                    self.errorViewModel?.errorDescription = error.weatherError.errorDescription
                    self.errorViewModel?.errorCode = "Error Code \(error.weatherError.errorCode)".uppercased()
                    
                    self.showingError = true
                    self.state = .errorView(error.weatherError.errorDescription)
                }
            }
        }
    }
    
    func getAsyncAstronomy() async {
        guard let locationManager = locationManager.locationManager.location else {
            self.state = .errorView("Location not found, please review device settings and restart app.")
            // TODO: Test if the location fails
            return
        }
        
        DunLocationState.sharedInstance.long = locationManager.coordinate.longitude.description
        DunLocationState.sharedInstance.lat = locationManager.coordinate.latitude.description
        
        let endpoint = WeatherEndpoints.getAstronomy
        Task {
            do {
                let astronomy = try await apiClient.asyncRequest(endpoint: endpoint, responseModel: WeatherSunResponseModel.self)
                
                await MainActor.run {
                    self.todoViewModel?.sunSetTime = astronomy.astronomy.astro.sunset
                    self.todoViewModel?.sunRiseTime = astronomy.astronomy.astro.sunrise
                    
                    self.state = .weatherReceived
                }
            } catch let error as WeatherErrorDetails {
                await MainActor.run {
                    self.errorViewModel?.errorDescription = error.weatherError.errorDescription.uppercased()
                    self.errorViewModel?.errorCode = ("Error Code: \(error.weatherError.errorCode)").uppercased()
                    
                    self.showingError = true
                    self.state = .errorView(error.weatherError.errorDescription.uppercased())
                }
            }
        }
    }
}
