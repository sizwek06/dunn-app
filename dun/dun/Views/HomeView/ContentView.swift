//
//  ContentView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack(spacing: 25) {
            createHeader(title: TodoStrings.weatherTitle)
                .padding(.vertical, 0)
                .frame(width: 325, height: 50, alignment: .leading)
            makeWeatherCard()
            
            ScrollView(.vertical) {
                createHeader(title: TodoStrings.todoListTitle)
                    .padding(.vertical, 5)
                    .frame(width: 325, height: 50, alignment: .leading)
                
                makeTodoListCard(item: ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                                todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                                isCompleted: false))
                makeTodoListCard(item: ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                                todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                                isCompleted: false))
                makeTodoListCard(item: ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                                todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                                isCompleted: false))
                makeTodoListCard(item: ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                                todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                                isCompleted: false))
                
                createHeader(title: TodoStrings.completedListTitle)
                    .padding(.vertical, 5)
                    .frame(width: 325, height: 50, alignment: .leading)
                
                makeTodoListCard(item: ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                                todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                                isCompleted: true))
                makeTodoListCard(item: ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                                todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                                isCompleted: true))
                makeTodoListCard(item: ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                                todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                                isCompleted: true))
                makeTodoListCard(item: ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                                todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                                isCompleted: true))
            }
            .padding(.top, 10)
        }
    }
    
    private func createHeader(title: String) -> some View {
        HStack {
            Text(title)
                .font(.custom(TodoStrings.sfProRounded,
                              size: 20))
        }
    }
    
    private func makeWeatherCard() -> some View {
        HStack(spacing: 10) {
            Image("03d")
                .resizable()
                .frame(width: 80, height: 80)
                .padding(.leading, 30)
            weatherText()
                .padding(.horizontal, 18)
                .padding(.trailing, 18)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24.0))
        .shadow(radius: 8)
        .frame(width: 325, height: 40, alignment: .center)
    }
    
    func weatherText() -> some View {
        VStack() {
            Text(TodoStrings.currentTemperature)
                    .font(.headline)
            HStack {
                Text(TodoStrings.sunsetTime)
                    .font(.headline)
                Text(TodoStrings.sunriseTime)
                        .font(.headline)
            }
            HStack(spacing: 4.0) {
                Image(systemName: "location")
                Text("South Africa")
            }.foregroundColor(.gray)
            .padding(.bottom, 16)
        }
        .padding(.top, 16)
    }
    
    private func makeTodoListCard(item: ToDoItem) -> some View {
        HStack(spacing: 10) {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(returnColour(using: item.isCompleted))
            createTodoTitle(item: item)
        }
        .padding(.horizontal, 10)
        .frame(width: 325, height: 55, alignment: .leading)
        .overlay {
            RoundedRectangle(cornerRadius: 4)
                .stroke(returnColour(using: item.isCompleted),
                        lineWidth: 1)
        }
    }
    
    private func createTodoTitle(item: ToDoItem) -> some View {
        VStack() {
            Text(item.itemTitle)
                .font(.custom(TodoStrings.sfProRegular,
                              size: 17))
                .padding(.horizontal, -85)
                .strikethrough(item.isCompleted)
                .foregroundColor(returnColour(using: item.isCompleted))
            Text(item.itemDescription)
                .font(.custom(TodoStrings.sfProRegular,
                              size: 17))
                .strikethrough(item.isCompleted)
                .foregroundColor(returnColour(using: item.isCompleted))
        }
        
    }
    
    func returnColour(using isCompleted: Bool) -> Color {
        return isCompleted ? .gray : .black
    }
}

#Preview {
    ContentView()
}
