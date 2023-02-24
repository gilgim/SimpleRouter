//
//  ExerciseView.swift
//  Router
//
//  Created by Gaea on 2023/02/21.
//

import SwiftUI

struct ExerciseView: View {
    @State var searchText: String = ""
    var body: some View {
        VStack {
            SearchBarView(searchText: $searchText)
                .padding()
            List {
                
            }
            .listStyle(InsetListStyle())
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    ExerciseCreate()
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
