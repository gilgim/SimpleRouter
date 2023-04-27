//
//  ContentView.swift
//  SimpleRoutine
//
//  Created by Gaea on 2023/04/21.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    var body: some View {
        NavigationStack {
            TabView {
                NavigationView {
                    ExerciseListView()
                        .navigationTitle("운동 목록")
                }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Exercise")
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
