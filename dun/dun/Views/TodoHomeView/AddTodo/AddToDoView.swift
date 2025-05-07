//
//  AddToDoView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/05.
//

import SwiftUICore
import SwiftUI

struct AddToDoView: View {
    @ScaledMetric(relativeTo: .body) var dynamicTextSize = 14
    
    @State private var todoTitle: String = ""
    @State private var todoDescription: String = ""
    @State private var isCompleted: String = ""
    
    @FocusState private var fieldFocused: FocusedField?
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var todo: ToDoItems?
    @State var switchToggle: Bool = false
    @State var formValid: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Todo Title",
                              text: $todoTitle)
                    .focused($fieldFocused, equals: .title)
                    .submitLabel(.next)
                    .onAppear(perform: {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    })
                    .onSubmit {
                        fieldFocused = .description
                    }
                    TextField("Todo Description",
                              text: $todoDescription)
                    .focused($fieldFocused, equals: .description)
                    .submitLabel(.done)
                    .onAppear(perform: {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    })
                    .onSubmit {
                        if todoTitle.isEmpty {
                            fieldFocused = .title
                        } else if todoDescription.isEmpty {
                            fieldFocused = .description
                        } else {
                            self.createTodDo(item: ToDoItem(id: UUID(), itemTitle: todoTitle,
                                                            todoDescription: todoDescription,
                                                            isCompleted: "todo"))
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Section {
                        Toggle(isOn: $switchToggle) {
                            Text("Mark as complete")
                                .font(.custom(TodoStrings.sfProBold,
                                              size: dynamicTextSize))
                                .onChange(of: switchToggle) {
                                    
                                    self.createTodDo(item: ToDoItem(id: UUID(), itemTitle: todoTitle,
                                                                    todoDescription: todoDescription,
                                                                    isCompleted: switchToggle ? "done" : "todo"))
                                }
                        }.disabled(todo == nil || (todoTitle.isEmpty || todoDescription.isEmpty))
                    }
                }
                .textInputAutocapitalization(.words)
                .disableAutocorrection(false)
            }
            .onAppear {
                if let todo = todo {
                    self.todoTitle = todo.itemTitle
                    self.todoDescription = todo.itemDescription
                    self.isCompleted = todo.isCompleted
                }
                
                fieldFocused = .title
            }
            .navigationTitle(todo == nil ? "Add a new ToDo" : "Update \(self.todoTitle)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Dismiss",
                              systemImage: "xmark.circle.fill")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.createTodDo(item: ToDoItem(id: UUID(), itemTitle: todoTitle,
                                                        todoDescription: todoDescription,
                                                        isCompleted: "todo"))
                    } label: {
                        Label("Add New",
                              systemImage: "square.and.arrow.down.on.square")
                    }.disabled(todoTitle.isEmpty || todoDescription.isEmpty)
                }
            })
        }
    }
    
    private func createTodDo(item: ToDoItem) {
        if todo == nil {
            todo = ToDoItems(context: self.viewContext)
            todo?.itemIdentifier = UUID()
        }
        
        todo?.itemTitle = item.itemTitle
        todo?.itemDescription = item.itemDescription
        todo?.isCompleted = item.isCompleted ?? "todo"
        
        do {
            try self.viewContext.save()
            print("Todo saved!")
        } catch {
            print("whoops \\(error.localizedDescription)")
        }
        dismiss()
    }
}

enum FocusedField {
    case title, description
}

#Preview {
    AddToDoView()
}
