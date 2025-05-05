//
//  AddToDoView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/05.
//

import SwiftUICore
import SwiftUI

struct AddToDoView: View {
    @ScaledMetric(relativeTo: .headline) var dynamicHeaderSize = 17
    @ScaledMetric(relativeTo: .title) var dynamicTitleSize = 15
    @ScaledMetric(relativeTo: .body) var dynamicTextSize = 12
    
    @State private var todoTitle: String = ""
    @State private var todoDescription: String = ""
    
    @FocusState private var fieldFocused: FocusedField?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
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
                        // TODO: Add Todo
                    }
                    .buttonStyle(.borderedProminent)
                }
                .textInputAutocapitalization(.words)
                .disableAutocorrection(false)
                //                .border(.secondary)
                //            Text(nameComponents.debugDescription) TODO: // Revisit this
            }
            .navigationTitle("Add a new ToDo")
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
                        // TODO: Add new item then dismiss()
                        // Refreshing the rootView
                        dismiss()
                    } label: {
                        Label("Add New",
                              systemImage: "square.and.arrow.down.on.square")
                    }
                }
            })
        }
        .onAppear {
            fieldFocused = .title
        }
    }
    
    private func addToDo() {
        dismiss()
    }
    
    private func createTextField(with todoTitle: String) {
        
    }
}

enum FocusedField {
        case title, description
    }

#Preview {
    AddToDoView()
}
