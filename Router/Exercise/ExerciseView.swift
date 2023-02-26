//
//  ExerciseView.swift
//  Router
//
//  Created by Gaea on 2023/02/21.
//

import SwiftUI

struct ExerciseView: View {
	@Environment(\.presentationMode) var mode
	@StateObject var vm = ExerciseViewModel()
    @State var searchText: String = ""
	@Binding var selectExercise: Exercise?
	init(selctExercise: Binding<Exercise?> = .constant(nil)) {
		_selectExercise = selctExercise
	}
    var body: some View {
        VStack {
            SearchBarView(searchText: $searchText)
                .padding()
            List {
				ForEach(vm.exercises, id:\.self) { exercise in
					Button {
						if mode.wrappedValue.isPresented {
							self.selectExercise = exercise
						}
					} label:{
						HStack {
							Circle()
								.foregroundColor(Color(hex:exercise.symbolColorHex ?? "FFFFFF"))
								.overlay(
									Image(systemName:exercise.symbolName ?? "plus")
										.resizable()
										.scaledToFit()
										.padding()
								)
							VStack {
								Text(exercise.exerciseName ?? "Nothing")
								Text(exercise.exercisePart ?? "Nothing")
							}
						}
						.frame(height:100)
					}
				}
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
		.onAppear() {
			self.vm.readExercise()
		}
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
