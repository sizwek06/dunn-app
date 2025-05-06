//
//  TodoViewModel.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import Foundation
import SwiftUICore

class TodoViewModel: ContentViewModel {
    
    @State var todoArray: [ToDoItems] = []
    @State var completedArray: [ToDoItems] = []
    
    @State var shouldAskForTodo: Bool = false
    
    func resetArrays() {
        self.todoArray = []
        self.completedArray = []
    }
}

