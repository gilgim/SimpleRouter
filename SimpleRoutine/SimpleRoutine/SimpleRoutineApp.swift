//
//  SimpleRoutineApp.swift
//  SimpleRoutine
//
//  Created by Gaea on 2023/04/21.
//

import SwiftUI
import UIKit
import WatchConnectivity

@main
struct SimpleRoutineApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
