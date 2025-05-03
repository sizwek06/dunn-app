//
//  TodoStrings.swift
//  dūn
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import Foundation
import UIKit
import SwiftUICore

struct TodoStrings {
    
    static let weatherTitle = "Today's Weather"
    static let currentTemperature = "Temp: "
    static let sunsetTime = "Sunset: "
    static let sunriseTime = "| Sunrise: "
    
    static let todoListTitle = "To-Do List"
    static let completedListTitle = "Completed List"
    static let todoItemTitlePlaceHolder = "Cereal"
    static let todoItemDescrPlaceHolder = "Get cereal ingredients"
    static let noTodoItemsListText = "No Todo Items"
    
    static let settingsViewTitle = "Settings"
    static let settingsViewSubtitle = "Configure the following Settings"
    
    static let generalUnknownError = "An unknown error occurred"
    static let todoStoredKey = "todoStoredKey"
    static let todoEntityKey = "ToDoItems"
    static let completedToDoEntityKey = "CompletedToDoItems"
    
    static let coreDataDescription = "itemDescription"
    static let coreDataCompletion = "isCompleted"
    
    static let alertCancel = "Cancel"
    static let alertCcomplete = "Complete"
    
    static let userDefaultBiometricsKey = "faceID"
    static let useFaceIDText = "Use FaceID"
    
    static let sfProRounded = "SFProRounded-Bold"
    static let sfProRegular = "SF-ProText-Regular"
}

extension Color {
    
    static var appearanceColor: Color { Color(UIColor(named: "AppearanceColor") ?? UIColor(Color.white)) }
    static var generalBackground: Color { Color(UIColor(named: "GeneralBackround") ?? UIColor(Color.white)) }
}
