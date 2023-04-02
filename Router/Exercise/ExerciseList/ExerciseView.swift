//
//  ExerciseView.swift
//  Router
//
//  Created by Gaea on 2023/02/21.
//

import SwiftUI
import Combine

struct ExerciseView: View {
	@Environment(\.presentationMode) var mode
    @State var isAlert = false
    @StateObject var vm = ExerciseViewModel()
    
    @State var searchText: String = ""
    @State var isKeyboardOpen: Bool = false
    @State var exercises: [Exercise] = []
//    @State var sample = [Exercise(exerciseName: "샘플", symbolName: "person.fill", symbolColorHex: "3F5136", exercisePart: "샘플부위", restTime: 0, set: 0)]
	@Binding var selectExercise: Exercise?
    @Binding var isSheetPop: Bool
    
    ///  운동 생성 화면 이동 변수
    @State var modifyTargetExercise: Exercise? = nil
    @State var isGoCreateView = false
    
    init(isSheetPop: Binding<Bool> = .constant(false), selectExercise: Binding<Exercise?> = .constant(nil)) {
        _isSheetPop = isSheetPop
		_selectExercise = selectExercise
	}
    private var cancelables = Set<AnyCancellable>()
    
    var body: some View {
        VStack(spacing:0) {
            //  ========== 검색 뷰 ===========
            SearchBarView(isKeyBoardOpen: $isKeyboardOpen,searchText: $searchText)
                .padding(.horizontal)
                .padding(.top)
            
            //  ========== 리스트 ==========
            List {
                ForEach(exercises, id:\.id) { exercise in
                    if searchText == "" || exercise.exerciseName.contains(searchText) {
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
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color(hex:exercise.symbolColorHex))
                                    Image(systemName:exercise.symbolName)
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .padding(20)
                                }
                                //  ========== 운동명 ===========
                                //  추후 기록된 운동 정보로 값 갱신
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
                        .frame(height: 80).padding(.vertical,5)
                        //  스와이프 관련
                        .customSwipeAction(isSwipeAble: !isKeyboardOpen) {
                            Button {
                                self.vm.modifyTargetExercise = exercise
                                self.vm.deleteExercise()
                                self.vm.readExercise()
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
                        }
                    }
                }
            }
            .listStyle(InsetListStyle())
            .customTapGesture(isTapAble: isKeyboardOpen) {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        //  MARK: 뷰 생성 시점
        .onAppear() {
            self.vm.exercisesClosure = { exercises in
                withAnimation {
                    self.exercises = exercises
                }
            }
            self.vm.modifyTargetClosure = { exercise in
                withAnimation {
                    self.modifyTargetExercise = exercise
                }
            }
            //  vm의 alert 메세지가 변화할 때 마다 alert를 자동으로 활성화 해주기 위한 로직
            self.vm.alertClosure = {
                self.isAlert = true
            }
            
            self.vm.readExercise()
        }
        //  MARK: Navigation 관련
        .navigationTitle("운동 목록")
        .navigationBarTitleDisplayMode(.inline)
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
        //  운동 생성 및 운동 수정 네비게이션.
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
        Group {
            ExerciseView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
                
            ExerciseView()
                .previewDevice(PreviewDevice.init(rawValue: "iPhone SE"))
                
        }
    }
}
