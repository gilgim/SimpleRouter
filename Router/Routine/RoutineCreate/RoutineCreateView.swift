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
    @State var isExerciseSetting = false
    @State var isModifySet = false
    @State var isModifyRestTime = false
	@State var selectExercise: Exercise? = nil
    
    @State var setText: String = ""
    
    @State var completeAlertText = ""
    @State var isCompleteAlert = false
    @StateObject var vm = RoutineCreateViewModel()
    var body: some View {
		List {
            Section("이름") {
                TextField("루틴명", text: $vm.routineName)
            }
			Section("운동 목록") {
                ForEach(vm.selectExercises.indices, id:\.self) { i in
                    Button {
                        isExerciseSetting = true
                    }label: {
                        HStack {
                            Circle()
                                .foregroundColor(Color(hex:vm.selectExercises[i].symbolColorHex ?? "FFFFFF"))
                                .overlay(
                                    Image(systemName:vm.selectExercises[i].symbolName ?? "plus")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                        .foregroundColor(.white)
                                )
                            VStack {
                                Text(vm.selectExercises[i].exerciseName ?? "Nothing")
                                Text(vm.selectExercises[i].exercisePart ?? "Nothing")
                            }
                        }
                        .frame(height:50)
                    }
                    .confirmationDialog("수정사항", isPresented: $isExerciseSetting) {
                        Button("세트") {self.isModifySet = true}
                        Button("휴식시간") {self.isModifyRestTime = true}
                    }
                    .alert("세트 수 변경",isPresented: $isModifySet) {
                        TextField("Enter a number", text: $setText)
                            .keyboardType(.numberPad)
                        Button("확인") {
                            if setText == setText.filter({$0.isNumber}) {
                                vm.selectExercises[i].set = Int16(setText)
                                self.completeAlertText = "세트가 \(setText)로 변경되었습니다."
                                self.isCompleteAlert = true
                            }
                            else {
                                self.completeAlertText = "값이 올바르지 않아 저장되지 않았습니다."
                                self.isCompleteAlert = true
                            }
                        }
                    }
                    .alert("휴식시간 변경", isPresented: $isModifyRestTime) {
//                        TextField("휴식시간은 초로 설정해주세요.",text: $vm.restTimeValue)
//                            .keyboardType(.numberPad)
                    }
                }
                
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
                }
            }
        })
        .alert("변경완료", isPresented: $isCompleteAlert, actions: {
            Text(completeAlertText)
            Button("완료") {}
        })
        .sheet(isPresented: $isPresentExercise, onDismiss: {
            if var selectExercise {
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
