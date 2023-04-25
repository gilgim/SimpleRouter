//
//  WorkOutView.swift
//  SimpleRoutine Watch App
//
//  Created by Gaea on 2023/04/21.
//

import SwiftUI
import WatchConnectivity

struct WorkOutView: View {
    var body: some View {
        TabView {
            RunningView()
        }
    }
}
struct RunningView: View {
    @ObservedObject private var connectivityManager = WatchConnectivityManager.shared
    var body: some View {
        Button("Test Button") {
            WatchConnectivityManager.shared.send("Test")
        }
        .alert(item: $connectivityManager.notificationMessage) { message in
             Alert(title: Text(message.text),
                   dismissButton: .default(Text("Dismiss")))
        }
    }
}
struct WorkOutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkOutView()
    }
}
