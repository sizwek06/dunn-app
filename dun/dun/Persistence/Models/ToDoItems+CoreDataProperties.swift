//
//  ToDoItems+CoreDataProperties.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/05.
//
//

import Foundation
import CoreData
import SwiftUICore

extension ToDoItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItems> {
        return NSFetchRequest<ToDoItems>(entityName: "ToDoItems")
    }

    @NSManaged public var isCompleted: String
    @NSManaged public var itemDescription: String
    @NSManaged public var itemTitle: String
    @NSManaged public var itemIdentifier: UUID
    
    var returnTitleColor: Color {
        return isCompleted == "done" ? .black : .appearanceColor
    }
}

extension ToDoItems : Identifiable {

}
