//
//  ContentViewModel.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import Foundation
import SwiftUI
import CoreLocation

class ContentViewModel: NSObject, ObservableObject {
    
    enum ViewState: Equatable {
        case loading
        case weatherReceived
        case locationUnknown
    }
    
    var currentTemp: Double = 0
    var sunRiseTime: String = "12 AM"
    var sunSetTime: String = "12 PM"
    
    var city: String = "Paris"
    var country: String = "France"
    var condition: Condition?
    // TODO: make above struct
    
    var todoViewModel: TodoViewModel?
    var errorDescription: String?
    var errorCode: String?
    
    @Published var showingError = false
    @Published var viewState: ViewState = .loading
    
    let locationManager: CLLocationManager!
    let apiClient: DunApiProtocol!
    
    public init(apiClient: DunApiProtocol = DunApiClient(),
                locationManager: CLLocationManager = CLLocationManager()) {
        
        self.apiClient = apiClient
        self.locationManager = CLLocationManager()
    }
    
    func getAsyncWeather() async {
        
        self.todoViewModel = TodoViewModel(apiClient: self.apiClient)
        
        guard let locationManager = locationManager.location else {
            self.errorCode = "Location not found.".uppercased()
            self.errorDescription = "Rlease review device's location settings and restart app.".uppercased()
            
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
                    
                    self.viewState = .weatherReceived
                }
            } catch let error as WeatherErrorDetails {
                await MainActor.run {
                    self.showingError = true
                    self.errorDescription = error.weatherError.errorDescription
                }
            }
        }
    }
    
    func getAsyncAstronomy() async {
        guard let locationManager = locationManager.location else {
            self.errorCode = "Location not found.".uppercased()
            self.errorDescription = "Rlease review device's location settings and restart app.".uppercased()
            
            return
        }
        
        DunLocationState.sharedInstance.long = locationManager.coordinate.longitude.description
        DunLocationState.sharedInstance.lat = locationManager.coordinate.latitude.description
        
        let endpoint = WeatherEndpoints.getAstronomy
        Task {
            do {
                let astronomy = try await apiClient.asyncRequest(endpoint: endpoint, responseModel: WeatherAstronomyResponseModel.self)
                
                await MainActor.run {
                    self.todoViewModel?.sunSetTime = astronomy.astronomy.astro.sunset
                    self.todoViewModel?.sunRiseTime = astronomy.astronomy.astro.sunrise
                    
                    self.viewState = .weatherReceived
                }
            } catch let error as WeatherErrorDetails {
                await MainActor.run {
                    self.errorDescription = error.weatherError.errorDescription.uppercased()
                    self.errorCode = ("Error Code: \(error.weatherError.errorCode)").uppercased()
                    
                    self.showingError = true
                    self.errorDescription = error.weatherError.errorDescription
                }
            }
        }
    }
    
    func checkLocationStatus() -> ViewState {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways, .authorized:
            return .loading
        default:
            return .locationUnknown
        }
    }
}
