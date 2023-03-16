//
//  RoutineCreateView.swift
//  Router
//
//  Created by KimWooJin on 2023/02/26.
//

import SwiftUI
import Combine

struct RoutineCreateView: View {
    @Environment(\.presentationMode) var mode
    
    @State var isPresentExercise = false
	@State var selectExercise: Exercise? = nil
    
    @StateObject var vm = RoutineCreateViewModel()
    var body: some View {
		List {
            Section("이름") {
                TextField("루틴명", text: $vm.routineName)
            }
            ForEach(vm.selectExercises.indices, id:\.self) { i in
                Section(vm.selectExercises[i].exerciseName) {
                    Button {
                        
                    }label: {
                        HStack {
                            Circle()
                                .foregroundColor(Color(hex:vm.selectExercises[i].symbolColorHex ))
                                .overlay(
                                    Image(systemName:vm.selectExercises[i].symbolName )
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                        .foregroundColor(.white)
                                )
                            VStack {
                                Text(vm.selectExercises[i].exerciseName )
                                Text(vm.selectExercises[i].exercisePart )
                            }
                        }
                        .frame(height:50)
                    }
                }
			}
            Section {
                Button {
                    self.isPresentExercise = true
                }label: {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                        Spacer()
                    }
                }
            }
		}
		.toolbar(content: {
			ToolbarItem(placement:.navigationBarTrailing) {
				Button("생성") {
                    self.vm.createRoutine()
                    self.mode.wrappedValue.dismiss()
				}
			}
		})
        .sheet(isPresented: $isPresentExercise, onDismiss: {
            if var selectExercise = self.selectExercise {
				//	세트 수 5개
				selectExercise.set = 5
				//	휴식 시간 1분
				selectExercise.restTime = 60
                self.vm.selectExercises.append(selectExercise)
            }
            self.selectExercise = nil
        }, content: {
			ExerciseView(isSheetPop: $isPresentExercise,selctExercise: $selectExercise)
		})
		.navigationTitle("루틴 생성")
		.navigationBarTitleDisplayMode(.large)
    }
}

struct RoutineCreateView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineCreateView()
    }
}
