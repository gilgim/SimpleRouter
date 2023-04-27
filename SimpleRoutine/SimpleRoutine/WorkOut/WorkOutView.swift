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
    
    @Binding var exercise: Exercise?
    @Binding var routine: Routine?
    
    init(exercise: Binding<Exercise?> = .constant(nil), routine: Binding<Routine?> = .constant(nil)){
        self._exercise = exercise
        self._routine = routine
    }
    
    var body: some View {
        VStack {
            Button ("phone") {
//                WatchConnectivityManager.shared.send("Test")
            }
        }
    }
}
