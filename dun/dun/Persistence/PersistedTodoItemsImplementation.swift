//
//  PersistedTodoItemsImplementation.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/05.
//

import Foundation
import CoreData
import UIKit

final class PersistedTodoItemsImplementation: PersistedTodoItemsProtocol {
    
    static let shared = PersistedTodoItemsImplementation()
    
    var managedObjectContext: NSManagedObjectContext {
        let persistenceController = PersistenceController()
        return persistenceController.container.viewContext
    }
    
    func getTodoRequest(isCompletedItems: Bool) -> NSFetchRequest<NSFetchRequestResult> {
        return isCompletedItems ? NSFetchRequest<NSFetchRequestResult>(entityName: ToDoItem.completedTodoEntityName) :  NSFetchRequest<NSFetchRequestResult>(entityName: ToDoItem.todoEntityName)
    }
    
    func clearTodoItemsData(isCompletedItems: Bool = true) {
        do {
            let fetchRequest = getTodoRequest(isCompletedItems: isCompletedItems)
            let transactions = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            _ = transactions.map {
                $0.map {
                    managedObjectContext.delete($0)
                }
            }
            try managedObjectContext.save()
            print("Successful Transactions from Cleared CoreData")
        } catch let error {
            print("Error Transactions from CoreData: \(error)")
        }
    }
    
    func createTodoEntity(from newTodoItem: ToDoItem, isCompletedItems: Bool) -> NSManagedObject? {
        
        let entityName = isCompletedItems ? ToDoItem.completedTodoEntityName : ToDoItem.todoEntityName
        
        let todoItem = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                           into: managedObjectContext)
        
        todoItem.setValue(newTodoItem.itemTitle, forKey: TodoStrings.coreDataTitle)
        todoItem.setValue(newTodoItem.itemDescription, forKey: TodoStrings.coreDataDescription)
        todoItem.setValue(newTodoItem.isCompleted, forKey: TodoStrings.coreDataCompletion)
        return todoItem
    }
    
    func createTodoItemFromManagedObject(from todoItemObject: NSManagedObject) -> ToDoItem {
        let newTodoItem = ToDoItem(itemtitle:  todoItemObject.value(forKey: TodoStrings.coreDataTitle) as? String ?? TodoStrings.generalUnknownError,
                                   todoDescription: todoItemObject.value(forKey: TodoStrings.coreDataDescription) as? String ?? TodoStrings.generalUnknownError,
                                   isCompleted: todoItemObject.value(forKey: TodoStrings.coreDataCompletion) as? Bool ?? false)
        
        return newTodoItem
    }
    
    func saveToDoItemsToCoreData(todoItems: [ToDoItem], isCompletedItems: Bool) {
        
        
        _ = todoItems.map {
            self.createTodoEntity(from: $0, isCompletedItems: isCompletedItems)
        }
        
        do {
            try managedObjectContext.save()
            print("Successfully saved Transactions from CoreData")
        } catch let error {
            print("Error occurred saving to Core Data: \(error)")
        }
    }
    
    func fetchPersistedTodoItems(isCompletedItems: Bool) -> [ToDoItem] {
        
        var todoItems: [ToDoItem] = []
        let fetchRequest = getTodoRequest(isCompletedItems: isCompletedItems)
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            guard let todoItemsData = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] else {
                return []
            }
            
            for todoObject in todoItemsData {
                let todoItem = createTodoItemFromManagedObject(from: todoObject)
                todoItems.append(todoItem)
            }
            print("Successfully retrieved Transactions from CoreData")
            return todoItems

        } catch let error {
            print("Failed to fetch Transactions with error: \(error)")
            return []
        }
    }
}
