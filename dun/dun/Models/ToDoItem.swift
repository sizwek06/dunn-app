//
//  ToDoItem.swift
//  dūn
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import Foundation

struct ToDoItem {
    
    var itemTitle: String!
    var itemDescription: String!
    var isCompleted: Bool!
    
    public static var todoEntityName: String {
        return TodoStrings.todoEntityKey
    }
    
    public static var completedTodoEntityName: String {
        return TodoStrings.completedToDoEntityKey
    }
    
    public init(itemtitle: String,
                todoDescription: String,
                isCompleted: Bool) {
        
        self.itemTitle = itemtitle
        self.itemDescription = todoDescription
        self.isCompleted = isCompleted
    }
}
