//
//  ContentView.swift
//  SimpleRoutine Watch App
//
//  Created by Gaea on 2023/04/21.
//

import SwiftUI

struct ContentView: View {
    enum ViewType {
        case exercise, routine
    }
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(value: ViewType.exercise) {
                    Text("운동목록")
                }
                NavigationLink(value: ViewType.routine) {
                    Text("루틴목록")
                }
            }
            .navigationDestination(for: ViewType.self) {
                switch $0 {
                case .exercise:
                    NavigationView {
                        ExerciseListView()
                    }
                case .routine:
                    ExerciseListView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
