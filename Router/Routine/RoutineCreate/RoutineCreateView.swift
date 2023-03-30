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
                ForEach(selectExercises, id:\.self) { exercise in
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
                            //  라인이 텍스트먼저 인식해서 그림으로 인식으로 바꾸기
                            .alignmentGuide(.listRowSeparatorLeading) { d in
                                d[.leading]
                            }
                            //  운동 정보
                            VStack(alignment: .leading) {
                                //  운동명
                                Text(exercise.exerciseName)
                                    .font(Font.system(size: 24, weight: .medium, design: .rounded))
                                //  운동 세트 & 휴식
                                Text("\(exercise.set ?? 0)세트  |  \(exercise.restTime ?? 0)초")
                                    .foregroundColor(.gray)
                                    .padding(.bottom,2)
                                
                                //  부가적인 운동 항목이 추가되면 이 버튼을 통해 수정 및 추가 할 수 있다.
                                Button {
                                    
                                }label: {
                                    HStack(spacing:0) {
                                        Text("더보기")
                                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                    }
                                }
                                .foregroundColor(.init(hex: exercise.symbolColorHex))
                            }
                            .padding(.trailing)
                            .fixedSize()
                            Divider()
                                .overlay {Color.gray}
                            //  ========== 수정버튼 ==========
                            Button {
                                withAnimation {
                                    self.sample(exercise: exercise)
                                }
//                                self.vm.isSetRestAlert = true
                            }label: {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(20)
                            }
                            .foregroundColor(.init(hex: exercise.symbolColorHex))
                        }
                        .padding(.vertical)
                    }
                    .frame(height:UIScreen.main.bounds.height*0.15)
                }
                .buttonStyle(BorderlessButtonStyle())
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
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
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
            ExerciseView(isSheetPop: $isPresentExercise,selctExercise: $vm.selectExercise)
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
        RoutineCreateView()
    }
}

//  MARK: -Function
extension RoutineCreateView {
    func sample(exercise: Exercise) {
        //  업데이트를 위한 클로져.
        let closure = {
            self.selectExercises.append(.init())
            self.selectExercises.removeLast()
        }
        let vc = SetRestAlertViewController(closure: closure, setPublisher: exercise.setPublisher, restPublisher: exercise.restPublisher, beforeSetInt: exercise.set!, beforeRestInt: exercise.restTime!)
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        UIApplication.shared.windows.first?.rootViewController?.present(vc, animated: true)
    }
}
