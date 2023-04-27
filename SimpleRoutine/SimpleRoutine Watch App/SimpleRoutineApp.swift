//
//  SimpleRoutineApp.swift
//  SimpleRoutine Watch App
//
//  Created by Gaea on 2023/04/21.
//

import SwiftUI

@main
struct SimpleRoutine_Watch_AppApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
