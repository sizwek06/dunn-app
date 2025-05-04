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
    
    var todoArray = [ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                              todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                              isCompleted: false),
                     ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                              todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                              isCompleted: false),
                     ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                              todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                              isCompleted: false),
                     ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                              todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                              isCompleted: false)]
    var completedArray = [ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                   todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                   isCompleted: true),
                          ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                   todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                   isCompleted: true),
                          ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                   todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                   isCompleted: true),
                          ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                   todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                   isCompleted: true)]
    
    var body: some View {
        NavigationStack {
            VStack {
                createHeader(title: TodoStrings.weatherTitle)
                makeWeatherCard()
                
                ScrollView(.vertical) {
                    createHeader(title: TodoStrings.todoListTitle, isTodo: true)
                    
                    ForEach(todoArray, id: \.id) { todoItem in
                        makeTodoListCard(item: todoItem)
                    }
                    
                    createHeader(title: TodoStrings.completedListTitle)
                    
                    ForEach(completedArray, id: \.id) { todoItem in
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
    
    private func createHeader(title: String, isTodo: Bool = false) -> some View {
        HStack() {
            Text(title)
                .font(.custom(TodoStrings.sfProRounded,
                              size: dynamicHeaderSize,
                              relativeTo: .title))
                .frame(width: TodoStrings.returnDesiredWidth() - (isTodo ? 90 : 50),
                       height: UIScreen.main.bounds.height / 3,
                       alignment: .leading)
            if isTodo {
                Image(systemName: "plus.square.on.square")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .frame(width: 20, height: 20)
                    .padding(.vertical)
            }
        }
        .frame(width: 325, height: 50, alignment: .leading)
    }
    
    func returnColour(using isCompleted: Bool) -> Color {
        return isCompleted ? .gray : .appearanceColor
    }
    
    func getWeatherDetails() async {
        print("Current Loader state \(self.viewModel.loading)")
        await self.viewModel.getAsyncWeather()
        await self.viewModel.getAsyncAstronomy()
        
        print("Current Loader state \(self.viewModel.loading)")
    }
}

#Preview {
    TodoView()
}
