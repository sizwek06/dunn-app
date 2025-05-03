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
        VStack(spacing: 25) {
            createHeader(title: TodoStrings.weatherTitle)
                .padding(.vertical, 0)
                .frame(width: 325, height: 50, alignment: .leading)
            makeWeatherCard()
            
            ScrollView(.vertical) {
                createHeader(title: TodoStrings.todoListTitle, isTodo: true)
                    .padding(.vertical, 5)
                    .frame(width: 325, height: 50, alignment: .leading)
                
                    ForEach(todoArray, id: \.id) { todoItem in
                        makeTodoListCard(item: todoItem)
                    }
                
                createHeader(title: TodoStrings.completedListTitle)
                    .padding(.vertical, 5)
                    .frame(width: 325, height: 50, alignment: .leading)
                
                ForEach(completedArray, id: \.id) { todoItem in
                    makeTodoListCard(item: todoItem)
                }
            }
            .padding(.top, 10)
        }
    }
    
    private func createHeader(title: String, isTodo: Bool = false) -> some View {
        HStack() {
            Text(title)
                .font(.custom(TodoStrings.sfProRounded,
                              size: 20))
                Spacer()
            if isTodo {
                Image(systemName: "plus.square.on.square")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .frame(width: 20, height: 20)
                    .padding(.vertical)
            }
        }
    }
    
    private func makeWeatherCard() -> some View {
        HStack(spacing: 10) {
            Image("04d")
                .resizable()
                .frame(width: 90, height: 90)
                .padding(.leading, 30)
            weatherText()
                .padding(.horizontal, 10)
                .padding(.trailing, 20)
        }
        .background(.generalBackround)
        .clipShape(RoundedRectangle(cornerRadius: 24.0))
        .shadow(radius: 8)
        .frame(width: 325, height: 40, alignment: .center)
        .padding(.horizontal, 20)
    }
    
    func weatherText() -> some View {
        VStack() {
            Text(TodoStrings.currentTemperature)
                .font(.custom(TodoStrings.sfProRounded,
                                  size: 17))
                    .foregroundColor(.appearanceColor)
            HStack {
                Text(TodoStrings.sunsetTime)
                    .font(.custom(TodoStrings.sfProRounded,
                                  size: 17))
                    .foregroundColor(.appearanceColor)
                Text(TodoStrings.sunriseTime)
                    .font(.custom(TodoStrings.sfProRounded,
                                  size: 17))
                    .foregroundColor(.appearanceColor)
            }
            HStack(spacing: 4.0) {
                Image(systemName: "location")
                Text("South Africa")
            }
            .font(.custom(TodoStrings.sfProRounded,
                           size: 17))
            .foregroundColor(.appearanceColor)
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
        return isCompleted ? .gray : .appearanceColor
    }
}

#Preview {
    ContentView()
}
