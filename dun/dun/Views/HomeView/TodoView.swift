//
//  HomeView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import SwiftUICore
import SwiftUI

struct TodoView: View {
    @ObservedObject var viewModel = TodoViewModel()
    @ScaledMetric(relativeTo: .headline) var dynamicHeaderSize = 17
    @ScaledMetric(relativeTo: .title) var dynamicTitleSize = 15
    @ScaledMetric(relativeTo: .body) var dynamicTextSize = 12
    
    @State var showAdd = false
    
    var body: some View {
        NavigationStack {
            VStack {
                createHeader(title: TodoStrings.weatherTitle)
                makeWeatherCard()
                
                ScrollView(.vertical) {
                    createHeader(title: TodoStrings.todoListTitle, isTodo: true)
                    
                    ForEach(self.viewModel.todoArray, id: \.id) { todoItem in
                        makeTodoListCard(item: todoItem)
                    }
                    
                    createHeader(title: TodoStrings.completedListTitle)
                    
                    ForEach(self.viewModel.completedArray, id: \.id) { todoItem in
                        makeTodoListCard(item: todoItem)
                    }
                }
                
            }.onAppear {
                
                Task {
                    await self.getWeatherDetails()
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .status) {
                    Text(TodoStrings.appName)
                        .font(.custom(TodoStrings.sfProRounded,
                                      size: 20,
                                      relativeTo: .title))
                }
            }
        }
    }
    
    func getWeatherDetails() async {
        await self.viewModel.getAsyncWeather()
        await self.viewModel.getAsyncAstronomy()
    }
}

#Preview {
    TodoView()
}
