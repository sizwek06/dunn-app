//
//  ToDoItem.swift
//  dūn
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import Foundation
import SwiftUICore

struct ToDoItem: Identifiable, Hashable {
    
    var id: UUID
    var itemTitle: String
    var itemDescription: String
    var isCompleted: String
    
    public static var todoEntityName: String {
        return TodoStrings.todoEntityKey
    }
    
    public static var completedTodoEntityName: String {
        return TodoStrings.completedToDoEntityKey
    }
    
    var returnTitleColor: Color {
        return isCompleted == "done" ? .gray : .appearanceColor
    }
    
    public init(id: UUID,
                itemTitle: String,
                todoDescription: String,
                isCompleted: String) {
        
        self.id = id
        self.itemTitle = itemTitle
        self.itemDescription = todoDescription
        self.isCompleted = isCompleted
    }
    
    func returnColor() -> Color {
        return isCompleted == "done" ? .gray : .appearanceColor
    }
}

enum ToDoStatus {
    case todo, done
}
