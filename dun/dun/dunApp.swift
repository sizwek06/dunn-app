//
//  dunApp.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import SwiftUI

@main
struct dunApp: App {
    @StateObject private var manager: DataManager = DataManager()
        
    var body: some Scene {
        WindowGroup {
            ContentView(model: ContentViewModel())
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
