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
    
    static let appName = "dūn"
    
    // MARK: Todo List
    static let weatherTitle = "Today's Weather"
    static let currentTemperature = "Temp: "
    static let sunsetTime = "Sunset: "
    static let sunriseTime = "Sunrise: "
    
    static let todoListTitle = "To-Do List"
    static let completedListTitle = "Completed List"
    static let todoItemTitlePlaceHolder = "Cereal"
    static let todoItemDescrPlaceHolder = "Get cereal ingredients"
    static let noTodoItemsListText = "No Todo Items"
    
    static let settingsViewTitle = "Settings"
    static let settingsViewSubtitle = "Configure the following Settings"
    
    static let generalUnknownError = "An Unknown Error has occurred"
    static let todoStoredKey = "todoStoredKey"
    
    // MARK: Todo List
    static let todoEntityKey = "ToDoItems"
    static let completedToDoEntityKey = "CompletedToDoItems"
    
    static let coreDataIdentifier = "itemIdentifier"
    static let coreDataTitle = "itemTitle"
    static let coreDataDescription = "itemDescription"
    static let coreDataCompletion = "isCompleted"
    
    static let productivityURL = "https://asana.com/resources/how-to-be-more-productive"
    static let productivitytext = "Need help?"
    // MARK: Fonts
    static let sfPro = "SF-ProText"
    static let sfProRounded = "SFProRounded-Bold"
    static let sfProRegular = "SF-ProText-Regular"
    static let sfProBold = "SF-ProText-Semibold"
    
    static let apiKey = Bundle.main.infoDictionary?["API_KEY"] ?? ""
    
    static func returnDesiredWidth() -> CGFloat {
        return UIScreen.main.bounds.width - 20
    }
    
    func returnColor(for itemComplete: Bool) -> Color {
        return itemComplete ? .gray : .appearanceColor
    }
}

extension Color {
    
    static var appearanceColor: Color { Color(UIColor(named: "AppearanceColor") ?? UIColor(Color.black)) }
    static var generalBackground: Color { Color(UIColor(named: "GeneralBackround") ?? UIColor(Color.white)) }
    static var graytextColor: Color { Color(UIColor(named: "GreyText") ?? UIColor(Color.white)) }
}
