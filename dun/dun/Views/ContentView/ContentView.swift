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
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: ContentViewModel
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
            animation: .default)
    private var items: FetchedResults<Item>
    
    init(model: ContentViewModel) {
        self.viewModel = ContentViewModel()
    }
    
    var body: some View {
        VStack(alignment: .center) {
            getBody()
                .onAppear {
                    Task {
                        await self.viewModel.getAsyncWeather()
                        await self.viewModel.getAsyncAstronomy()
                    }
                }
                .sheet(isPresented: self.$viewModel.showingError) {
                    ErrorView(viewModel: self.viewModel.errorViewModel ?? ErrorViewModel(),
                              isPresented: self.$viewModel.showingError)
                }
        }
    }
    
    @ViewBuilder
    fileprivate func getBody() -> some View {
        
        switch viewModel.state {
            
        case .loading:
            LoadingView()
        case .weatherReceived:
            TodoView(viewModel: self.viewModel.todoViewModel ?? TodoViewModel())
        case .errorView(_):
            ErrorView(viewModel: self.viewModel.errorViewModel ?? ErrorViewModel(),
                      isPresented:  self.$viewModel.showingError)
        }
    }
}

#Preview {
    ContentView(model: ContentViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
