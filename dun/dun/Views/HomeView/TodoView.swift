//
//  HomeView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import SwiftUICore
import SwiftUI
import CoreData

struct TodoView: View {
    @ObservedObject var viewModel = TodoViewModel()
    @ScaledMetric(relativeTo: .headline) var dynamicHeaderSize = 17
    @ScaledMetric(relativeTo: .title) var dynamicTitleSize = 15
    @ScaledMetric(relativeTo: .body) var dynamicTextSize = 12
    
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: []) private var todoFetchedResults: FetchedResults<ToDoItems>
    @State private var refreshID = UUID()
    @Binding var showAdd: Bool
    @State var showingOptions = false
    @State var todoListShown = true
    
    var body: some View {
        NavigationView {
            VStack {
                createHeader(currentSection: .weather)
                makeWeatherCard()
                createHeader(currentSection: todoListShown ? .todo : .completed)
                List {
                    ForEach(getCompletedTasks(forTodoList: todoListShown), id: \.self) { todoItem in
                        NavigationLink(destination: AddToDoView(todo: todoItem)) {
                            makeTodoListCard(item: todoItem)
                                .onTapGesture {
                                    self.openViewTask(todoItem: todoItem)
                                }
                        }.disabled(!todoListShown)
                    }
                    .onDelete(perform: deleteTask)
                }
                .listStyle(.inset)
                .padding(.bottom, 30)
                .padding(.leading, 20)
                .listRowSeparator(.hidden)
            }
            .onAppear {
                showAdd = false
                Task {
                    await self.getWeatherDetails()
                }
            }
            .navigationTitle(TodoStrings.appName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar (content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.todoListShown = !todoListShown
                    } label: {
                        Label("Archive",
                              systemImage: "archivebox")
                    }
                }
                ToolbarItem(placement: .status) {
                    Button {
                        // TODO Open Productivity Link?
                    } label: {
                        Label("Archive",
                              systemImage: "questionmark.circle.fill")
                    }
                }
            })
        }
    }
    
    func getWeatherDetails() async {
        await self.viewModel.getAsyncWeather()
        await self.viewModel.getAsyncAstronomy()
    }
    
    func getCompletedTasks(forTodoList: Bool) -> [ToDoItems] {
        var array: [ToDoItems] = []
        
        if forTodoList {
            todoFetchedResults.forEach { item in
                if item.isCompleted == "todo" {
                    array.append(item)
                }
            }
        } else {
            todoFetchedResults.forEach { item in
                if item.isCompleted != "todo" {
                    array.append(item)
                }
            }
        }
        
        return array
    }
    
    func openViewTask(todoItem: ToDoItems?) {
        showAdd.toggle()
        if let todoDoItem = todoItem {
           AddToDoView(todo: todoDoItem)
        } else {
            AddToDoView()
        }
    }
    
    func completeTask(at indexSet: IndexSet) {
        for index in indexSet {
            let item = todoFetchedResults[index]
            let todo = ToDoItems(context: self.viewContext)
            
            todo.itemIdentifier = item.itemIdentifier
            todo.itemTitle = item.itemTitle
            todo.isCompleted = item.isCompleted
            todo.itemDescription = item.itemDescription
            
            self.viewContext.delete(item)
            
            do {
                try viewContext.save()
                print("Delete done")
            } catch {
                print("Error deleting")
            }
        }
    }
    
    func deleteTask(at indexSet: IndexSet) {
        for index in indexSet {
            let todo = todoFetchedResults[index]
            self.viewContext.delete(todo)
            
            do {
                try viewContext.save()
                print("Delete done")
            } catch {
                print("Error deleting")
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var bool = true
        var body: some View {
            TodoView(showAdd: $bool)
        }
    }
    
    return Preview()
}
