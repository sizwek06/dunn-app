//
//  dunApp.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import SwiftUI

@main
struct dunApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
