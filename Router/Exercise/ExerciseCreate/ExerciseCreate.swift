//
//  ExerciseCreate.swift
//  Router
//
//  Created by Gaea on 2023/02/24.
//

import SwiftUI
import UIKit

struct ExerciseCreate: View {
    //  뷰 관련 변수
	@Environment(\.presentationMode) var mode
    @State var isAlert = false
    
	@StateObject var vm = ExerciseCreateViewModel()
    
    //  운동 수정시 필요한 값이다.
    //  Binding 되지 않으면 초기화 시점에서 오류가 발생한다.
    @Binding var modifyExercise: Exercise?
    
    //  수정을 위한 초기화
    init(exercise: Binding<Exercise?> = .constant(nil)) {
        _modifyExercise = exercise
    }
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    //  ========== 심볼 ==========
                    Circle()
                        .foregroundColor(Color(hex: self.vm.hex))
                        .overlay(
                            Image(systemName:self.vm.symbol)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .padding(20)
                        )
                    //  ========== 사용자 입력 TextField ==========
                    VStack {
						TextField("운동명", text: $vm.exerciseName)
                            .modifier(RoundedRectangleModifier())
                            .disabled(vm.viewType == .modify ? true : false)
						TextField("부위명", text: $vm.exercisePart)
                            .modifier(RoundedRectangleModifier())
                    }
                }
                .frame(maxHeight: 120)
                // ========== 색상 Picker ==========
                SymbolColorView(hex: $vm.hex)
                    .padding(.vertical)
                //  ========== 아이콘 Picker ==========
				SymbolImageView(symbol: $vm.symbol)
                    .padding(.vertical)
            }
            .padding()
        }
        //  MARK: 뷰 생성 이벤트
        .onAppear() {
            //  vm의 alert 메세지가 변화할 때 마다 alert를 자동으로 활성화 해주기 위한 로직
            vm.alertClosure = {
                self.isAlert = true
            }
            if let modifyExercise {
                vm.viewType = .modify
                vm.exerciseName = modifyExercise.exerciseName
                vm.exercisePart = modifyExercise.exercisePart
                vm.symbol = modifyExercise.symbolName
                vm.hex = modifyExercise.symbolColorHex
            }
        }
        //  MARK: Navigation 관련
        .navigationTitle("운동 생성")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(vm.viewType == .nomal ? "생성":"수정") {
                    if vm.viewType == .nomal {
                        self.vm.createExercise()
                    }
                    else if vm.viewType == .modify {
                        self.vm.updateExercise()
                    }
                    if self.isAlert == false {
                        self.mode.wrappedValue.dismiss()
                    }
                }
            }
        }
        //  MARK: Alert 관련
        .alert("에러", isPresented: $isAlert) {
            Text("확인")
        } message: {
            Text(vm.alertMessage)
        }
        .modifier(KeyboardHideModifier())

    }
}

struct ExerciseCreate_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCreate()
    }
}

struct SymbolImageView: View {
    @Binding var symbol: String
    var iconRows: [GridItem] = .init(repeating: GridItem(.adaptive(minimum: UIScreen.main.bounds.height*0.3/6),spacing: 0), count: 5)
    var body: some View {
        VStack{
            //  ========== 상단 텍스트 ==========
            HStack {
                Text("아이콘")
                    .font(Font.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.init(uiColor: .lightGray))
                Spacer()
            }
            //  ========== 아이콘 모음 ==========
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: iconRows, spacing: 10) {
                    ForEach(symbolName, id: \.self) { symbolName in
                        Button {
                            symbol = symbolName
                        }label: {
                            Image(systemName:symbolName)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height*0.3)
        }
        .modifier(RoundedRectangleModifier())
    }
}

struct SymbolColorView: View {
    @Binding var hex: String
    var colorRows: [GridItem] = .init(repeating: GridItem(.adaptive(minimum: UIScreen.main.bounds.height*0.3/6),spacing: 0), count: 5)
    var body: some View {
        VStack{
            //  ========== 상단 텍스트 ==========
            HStack {
                Text("색상")
                    .font(Font.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.init(uiColor: .lightGray))
                Spacer()
            }
            //  ========== 색상 목록 ==========
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: colorRows, spacing: 10) {
                    ForEach(colorHexs, id: \.self) { hex in
                        Button {
                            self.hex = hex
                        }label: {
                            Circle()
                            .foregroundColor(Color(hex: hex))
                            .overlay(
                                Circle()
                                    .stroke(lineWidth: 2)
                                    .padding(5)
                                    .foregroundColor(.white)
                            )
                            .padding(.bottom)
                        }
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height*0.3)
        }
        .modifier(RoundedRectangleModifier())
    }
}
