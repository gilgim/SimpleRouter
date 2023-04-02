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
    /// Message 업데이트 시 자동 alert
    @State var isAlert: Bool = false
//    @State var selectExercises: [Exercise] = [.init(exerciseName: "렛풀 다운", symbolName: "figure.walk", symbolColorHex: "3CB371", exercisePart: "운동부위명 입니다.", restTime: 60, set: 5)]
    @State var selectExercises: [Exercise] = []
    @State var selectExercise: Exercise? = nil
    @State var isPresentExercise = false
    @StateObject var vm = RoutineCreateViewModel()
    var body: some View {
		List {
            Section("이름") {
                TextField("루틴명", text: $vm.routineName)
            }
            Section("선택된 운동") {
                ForEach(vm.selectExercises, id:\.self) { exercise in
                    HStack {
                        HStack {
                            //  패딩과 라인이 곂치지 않게 하기 위한 VStack
                            VStack{
                                Circle()
                                    .foregroundColor(Color(hex:exercise.symbolColorHex))
                                    .overlay(
                                        Image(systemName:exercise.symbolName)
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
                                            .foregroundColor(.white)
                                    )
                                    .padding(.horizontal)
                            }
                            //  운동 정보
                            VStack(alignment: .leading) {
                                //  운동명
                                Text(exercise.exerciseName)
                                    .font(Font.system(size: 24, weight: .medium, design: .rounded))
                                //  운동 세트 & 휴식
                                HStack {
                                    Text("\(exercise.set ?? 0)세트  |  \(exercise.restTime ?? 0)초")
                                        .foregroundColor(.gray)
                                        .padding(.bottom,2)
                                    Spacer()
                                }
                            }
                            .fixedSize()
                            Spacer()
                                .overlay {Color.gray}
                            Button {
                                withAnimation {
                                    self.vm.alertSetAndRest(exercise: exercise)
                                    self.keyboardHide()
                                }
                            }label: {
                                HStack(spacing:0) {
                                    Image(systemName: "square.and.pencil")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                }
                            }
                            .foregroundColor(.init(hex: exercise.symbolColorHex))
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        .padding(.vertical)
                    }
                    .frame(height:100)
                    .swipeActions {
                        Button {
                            self.vm.removeExercise(exercise: exercise)
                        }label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                        
                        Button {
                            
                        }label: {
                            Image(systemName: "ellipsis")
                        }
                        .tint(.green)
                    }
                }
                Button {
                    self.isPresentExercise = true
                    self.keyboardHide()
                }label: {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                        Spacer()
                    }
                }
			}
		}
        //  MARK: 생명주기
        .onAppear() {
            self.vm.alertClosure = {
                self.isAlert = true
            }
            self.vm.selectExercisesClosure = { exercises in
                self.selectExercises = exercises
            }
            self.vm.selectExerciseClosure = { exercise in
                self.selectExercise = exercise
            }
        }
        //  MARK: Navigation 관련
		.toolbar(content: {
			ToolbarItem(placement:.navigationBarTrailing) {
				Button("생성") {
                    if self.vm.createRoutine() {
                        self.mode.wrappedValue.dismiss()
                    }
				}
			}
		})
		.navigationTitle("루틴 생성")
		.navigationBarTitleDisplayMode(.large)
        //  MARK: Alert 관련
        //  운동리스트 뷰 가져오기
        .sheet(isPresented: $isPresentExercise, onDismiss: {
            self.vm.setSetAndRestTime()
        }, content: {
            ExerciseView(isSheetPop: $isPresentExercise,selectExercise: $vm.selectExercise)
        })
        //  에러 팝업
        .alert("에러", isPresented: $isAlert, actions: {
            Button("확인"){}
        }, message: {
            Text(vm.alertMessage)
        })
    }
}

struct RoutineCreateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RoutineCreateView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
            RoutineCreateView()
        }
    }
}

//  MARK: -Function
extension RoutineCreateView {
    func keyboardHide() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
