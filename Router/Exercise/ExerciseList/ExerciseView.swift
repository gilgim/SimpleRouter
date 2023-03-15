//
//  ExerciseView.swift
//  Router
//
//  Created by Gaea on 2023/02/21.
//

import SwiftUI

struct ExerciseView: View {
	@Environment(\.presentationMode) var mode
    @State var isAlert = false
    @StateObject var vm = ExerciseViewModel()
    
    @State var searchText: String = ""
    
	@Binding var selectExercise: Exercise?
    @Binding var isSheetPop: Bool
    
    ///  운동 생성 화면 이동 변수
    @State var modifyTargetExercise: Exercise? = nil
    @State var isGoCreateView = false
    
    init(isSheetPop: Binding<Bool> = .constant(false), selectExercise: Binding<Exercise?> = .constant(nil)) {
        _isSheetPop = isSheetPop
		_selectExercise = selectExercise
	}
    
    var body: some View {
        VStack(spacing:0) {
            //  ========== 검색 뷰 ===========
            SearchBarView(searchText: $searchText)
                .padding(.horizontal)
                .padding(.top)
            List {
                ForEach(vm.exercises, id:\.id) { exercise in
                    Section {
                        //  ========== 리스트 내의 버튼 ==========
                        Button {
                            //  Routine에서 호출 됐을 때
                            if self.isSheetPop {
                                self.selectExercise = exercise
                                self.mode.wrappedValue.dismiss()
                            }
                        } label:{
                            HStack {
                                //  ========== 버튼 아이콘 ===========
                                Circle()
                                    .foregroundColor(Color(hex:exercise.symbolColorHex ))
                                    .overlay(
                                        Image(systemName:exercise.symbolName )
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
                                            .foregroundColor(.white)
                                    )
                                //  ========== 운동명 ===========
                                Text(exercise.exerciseName)
                                    .lineLimit(0)
                                    .font(Font.system(size: 25, weight: .regular, design: .rounded))
                                    .padding(.leading)
                                    .foregroundColor(.black)
                                Spacer()
                                VStack {
                                    Spacer()
                                    //  ========== 운동 부위 ===========
                                    Text(exercise.exercisePart)
                                        .foregroundColor(.gray.opacity(0.6))
                                }
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height*0.1)
                    }
                    .listRowBackground(Color.gray.opacity(0.2))
                    
                    //  스와이프 관련
                    .swipeActions(content: {
                        Button {
                            withAnimation(Animation.linear) {
                                self.vm.modifyTargetExercise = exercise
                                self.vm.deleteExercise()
                                self.vm.readExercise()
                            }
                        }label: {
                            Image(systemName: "trash.fill")
                        }
                        .tint(Color(hex: "ED4337"))
                        Button {
                            self.vm.modifyTargetExercise = exercise
                            self.isGoCreateView = true
                        }label: {
                            Image(systemName: "square.and.pencil")
                        }
                        .tint(Color(hex: "5DBB63"))
                    })
                    .listRowInsets(.none)
                }
            }
            .background(Color.clear)
            .scrollContentBackground(.hidden)
        }
        //  MARK: 뷰 생성 시점
        .onAppear() {
            self.vm.readExercise()
            self.vm.modifyTargetClosure = { exercise in
                self.modifyTargetExercise = exercise
            }
            //  vm의 alert 메세지가 변화할 때 마다 alert를 자동으로 활성화 해주기 위한 로직
            self.vm.alertClosure = {
                self.isAlert = true
            }
        }
        //  MARK: Navigation 관련
        .toolbar {
            if !isSheetPop {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.vm.modifyTargetExercise = nil
                        self.isGoCreateView = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            else {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.mode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }

                }
            }
        }
        .navigationDestination(isPresented: $isGoCreateView) {
            ExerciseCreate(exercise: $modifyTargetExercise)
        }
        //  MARK: Alert 관련
        .alert("에러", isPresented: $isAlert) {
            Text("확인")
        } message: {
            Text(vm.alertMessage)
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
