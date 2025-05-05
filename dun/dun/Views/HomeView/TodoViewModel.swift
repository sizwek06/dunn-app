//
//  TodoViewModel.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import ObjectiveC
import Foundation
import CoreLocation
import SwiftUICore

class TodoViewModel: ContentViewModel {
    
    @Published var todoArray = [ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                              todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                              isCompleted: false),
                     ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                              todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                              isCompleted: false),
                     ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                              todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                              isCompleted: false),
                     ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                              todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                              isCompleted: false)]
    @Published var completedArray = [ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                   todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                   isCompleted: true),
                          ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                   todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                   isCompleted: true),
                          ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                   todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                   isCompleted: true),
                          ToDoItem(itemtitle: TodoStrings.todoItemTitlePlaceHolder,
                                   todoDescription: TodoStrings.todoItemDescrPlaceHolder,
                                   isCompleted: true)]
    
    @State var shouldAskForTodo: Bool = false
    
    var persistedTodoItemsManager: PersistedTodoItemsProtocol!
    
    override init(apiClient: any DunApiProtocol = DunApiClient()) {
    }
    
    func addTodoItem(items: [ToDoItem], isCompleted: Bool = false) {
        let todoItemsStored = UserDefaults.standard.bool(forKey: TodoStrings.todoStoredKey)
        
        if todoItemsStored {
            self.persistedTodoItemsManager.clearTodoItemsData(isCompletedItems: false)
            self.resetArrays()
        }
        
        self.persistedTodoItemsManager.saveToDoItemsToCoreData(todoItems: items,
                                                               isCompletedItems: isCompleted)
        
        UserDefaults.standard.set(true, forKey: TodoStrings.todoStoredKey)
        retrieveStoredData()
    }
    
    func retrieveStoredData() {
        self.resetArrays()
        let todoItemsStored = UserDefaults.standard.bool(forKey: TodoStrings.todoStoredKey)
        
        if todoItemsStored {
            let todoItems = persistedTodoItemsManager.fetchPersistedTodoItems(isCompletedItems: false)
            let completedItems = persistedTodoItemsManager.fetchPersistedTodoItems(isCompletedItems: true)
            
            if todoItems.isEmpty {
                requestFirstTodo()
            }
            
            self.todoArray = todoItems
            self.completedArray = completedItems
        } else {
            self.requestFirstTodo()
        }
    }
    
//    TODO: Move below to OnAppear & show sheet
    func requestFirstTodo() {
        DispatchQueue.main.async {
            self.shouldAskForTodo = true
        }
    }
    
    func resetArrays() {
        self.todoArray = []
        self.completedArray = []
    }
}

class LocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            authorizationStatus = .authorizedWhenInUse
            
            locationManager.requestLocation()
            break
        case .restricted:
            authorizationStatus = .restricted
            break
        case .denied:
            authorizationStatus = .denied
            break
            
        case .notDetermined:
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          print("Location was updated")
    }
}
