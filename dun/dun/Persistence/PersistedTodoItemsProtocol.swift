//
//  PersistedTodoItemsProtocol.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/05.
//

import Foundation
import CoreData

protocol PersistedTodoItemsProtocol: AnyObject {
    var managedObjectContext: NSManagedObjectContext { get }
   
    func getTodoRequest(isCompletedItems: Bool) -> NSFetchRequest<NSFetchRequestResult>
    func clearTodoItemsData(isCompletedItems: Bool)
    func createTodoEntity(from newTodoItem: ToDoItem, isCompletedItems: Bool) -> NSManagedObject?
    func createTodoItemFromManagedObject(from ToDoItem: NSManagedObject) -> ToDoItem
    func saveToDoItemsToCoreData(todoItems: [ToDoItem], isCompletedItems: Bool)
    func fetchPersistedTodoItems(isCompletedItems: Bool) -> [ToDoItem]
}
