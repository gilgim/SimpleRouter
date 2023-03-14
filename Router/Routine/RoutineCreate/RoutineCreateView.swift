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
	@State var restTiemText: String = ""
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
                    .confirmationDialog("수정사항", isPresented: $isExerciseSetting) {
                        Button("세트") {self.isModifySet = true}
                        Button("휴식시간") {self.isModifyRestTime = true}
                    }
                    .alert("세트 수 변경",isPresented: $isModifySet) {
                        TextField("숫자만 입력해주세요.", text: $setText)
                            .keyboardType(.numberPad)
                        Button("확인") {
                            if setText == setText.filter({$0.isNumber}) {
								if let set = vm.selectExercises[i].set {
									self.completeAlertText = "세트 수가 \(set)번에서 \(setText)번으로 변경되었습니다."
									self.vm.selectExercises[i].set = Int16(setText)
									self.isCompleteAlert = true
								}
                            }
                            else {
                                self.completeAlertText = "값이 올바르지 않아 저장되지 않았습니다."
                                self.isCompleteAlert = true
                            }
							self.setText = ""
                        }
                    }
					.alert("변경", isPresented: $isCompleteAlert, actions: {
						Button("완료") {}
					}, message: {
						Text(completeAlertText)
					})
					.alert("휴식시간 변경",isPresented: $isModifyRestTime) {
						TextField("휴식시간은 초로 설정해주세요.(숫자만)", text: $restTiemText)
							.keyboardType(.numberPad)
						Button("확인") {
							if restTiemText == restTiemText.filter({$0.isNumber}) {
								if let restTime = vm.selectExercises[i].restTime {
									self.completeAlertText = "휴식시간이 \(restTime) 초에서 \(restTiemText) 초로 변경되었습니다."
									self.vm.selectExercises[i].restTime = Int16(restTiemText)
									self.isCompleteAlert = true
								}
							}
							else {
								self.completeAlertText = "값이 올바르지 않아 저장되지 않았습니다."
								self.isCompleteAlert = true
							}
							self.restTiemText = ""
						}
					}
					.alert("변경", isPresented: $isCompleteAlert, actions: {
						Button("완료") {}
					}, message: {
						Text(completeAlertText)
					})
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
                    self.mode.wrappedValue.dismiss()
				}
			}
		})
        .sheet(isPresented: $isPresentExercise, onDismiss: {
            if var selectExercise {
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
