//
//  ExerciseView.swift
//  Router
//
//  Created by Gaea on 2023/02/21.
//

import SwiftUI

struct ExerciseView: View {
	@Environment(\.presentationMode) var mode
    @Binding var isSheetPop: Bool
	@StateObject var vm = ExerciseViewModel()
    @State var searchText: String = ""
	@Binding var selectExercise: Exercise?
    init(isSheetPop: Binding<Bool> = .constant(false), selctExercise: Binding<Exercise?> = .constant(nil)) {
        _isSheetPop = isSheetPop
		_selectExercise = selctExercise
	}
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $searchText)
                    .padding()
                List {
                    ForEach(vm.exercises, id:\.id) { exercise in
                        Button {
                            if self.isSheetPop {
                                self.selectExercise = exercise
                                self.mode.wrappedValue.dismiss()
                            }
                        } label:{
                            HStack {
                                Circle()
                                    .foregroundColor(Color(hex:exercise.symbolColorHex ))
                                    .overlay(
                                        Image(systemName:exercise.symbolName )
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
                                            .foregroundColor(.white)
                                    )
                                VStack {
                                    Text(exercise.exerciseName )
                                    Text(exercise.exercisePart )
                                }
                            }
                            .frame(height:100)
                        }
                    }
                }
                .listStyle(InsetListStyle())
            }
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
