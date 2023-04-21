//
//  WorkOutView.swift
//  SimpleRoutine
//
//  Created by Gaea on 2023/04/21.
//

import Foundation
import SwiftUI
import WatchConnectivity

struct WorkOutView: View {
    @ObservedObject private var connectivityManager = WatchConnectivityManager.shared
    var body: some View {
        VStack {
            Button ("phone") {
                WatchConnectivityManager.shared.send("Test")
            }
        }
        .alert(item: $connectivityManager.notificationMessage) { message in
             Alert(title: Text(message.text),
                   dismissButton: .default(Text("Dismiss")))
        }
    }
}
