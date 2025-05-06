//
//  DataManager.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/05.
//

import CoreData
import Foundation

class DataManager: NSObject, ObservableObject {
    
    let container: NSPersistentContainer = NSPersistentContainer(name: "dun")
    
    @Published var todos: [ToDoItems] = [ToDoItems]()
    
    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
    }
}
