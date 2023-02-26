//
//  RoutineView.swift
//  Router
//
//  Created by Gaea on 2023/02/22.
//

import SwiftUI

struct RoutineView: View {
	@Environment(\.managedObjectContext) private var viewContext
	@State var searchText: String = ""
	var body: some View {
		VStack {
			SearchBarView(placeholder:"루틴명", searchText: $searchText)
				.padding()
			List {
//				ForEach(vm.exercises, id:\.self) { exercise in
//					HStack {
//						Circle()
//							.foregroundColor(Color(hex:exercise.symbolColorHex ?? "FFFFFF"))
//							.overlay(
//								Image(systemName:exercise.symbolName ?? "plus")
//									.resizable()
//									.scaledToFit()
//									.padding()
//							)
//						VStack {
//							Text(exercise.exerciseName ?? "Nothing")
//							Text(exercise.exercisePart ?? "Nothing")
//						}
//					}
//					.frame(height:100)
//				}
			}
			.listStyle(InsetListStyle())
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				NavigationLink {
					RoutineCreateView()
				} label: {
					Image(systemName: "plus")
				}

			}
		}
	}
}

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineView()
    }
}
