//
//  ContentView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import SwiftUI
import CoreData
import CoreLocation

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State var showAdd = false
    var locationManager = CLLocationManager()
    
    init(model: ContentViewModel) {
        self.viewModel = ContentViewModel()
        
    }
    
    var body: some View {
        
        VStack(alignment: .center) {
            getBody()
                .onAppear {
                    self.viewModel.requestLocation()
                    
                    if viewModel.viewState == .loading && !viewModel.showingError {
                        Task {
                            await getWeatherDetails()
                        }
                    }
                }
                .sheet(isPresented: self.$viewModel.showingError) {
                    ErrorView(isPresented: self.$viewModel.showingError, errorTitle: self.viewModel.errorCode,
                              errorDescription: self.viewModel.errorDescription)
                    
                }
                .onDisappear {
                    self.viewModel.showingError = false
                }
                .onChange(of: viewModel.showingError) {
                    self.viewModel.requestLocation()
                    
                    Task {
                        await getWeatherDetails()
                    }
                }
                .onChange(of: viewModel.viewState) {
                    Task {
                        await getWeatherDetails()
                    }
                }
        }
    }
    
    @ViewBuilder
    fileprivate func getBody() -> some View {
        
        switch viewModel.viewState {
            
        case .loading, .locationUnknown:
            LoadingView()
        case .weatherReceived:
            TodoView(viewModel: self.viewModel.todoViewModel ?? TodoViewModel(),
                     showAdd: $showAdd)
        }
    }
    
    func getWeatherDetails() async {
        self.viewModel.viewState = self.viewModel.checkLocationStatus()
        
        Task {
            await self.viewModel.getAsyncWeather()
            await self.viewModel.getAsyncAstronomy()
        }
    }
}

#Preview {
    ContentView(model: ContentViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
