//
//  WorkOutView.swift
//  SimpleRoutine Watch App
//
//  Created by Gaea on 2023/05/03.
//

import SwiftUI

struct SetRestView: View {
    @Environment(\.presentationMode) var mode
    @State var seletedExercise: Exercise?
    @Binding var isRunning: Bool
    @State var isSetViewShow: Bool = false
    @State var set: String = ""
    @State var isRestViewShow: Bool = false
    @State var restTime: String = ""
    var body: some View {
        VStack {
            Button {
                seletedExercise?.numberOfSets = 5
                seletedExercise?.restTime = 90
                mode.wrappedValue.dismiss()
                isRunning = true
            }label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(.gray.opacity(0.2))
                    VStack {
                        Text("기본 설정")
                            .font(Font.system(size: 18, weight: .bold, design: .default))
                        Text("5세트 및 1분 30초 휴식입니다.")
                            .font(Font.system(size: 12, weight: .light, design: .default))
                    }
                }
            }
            Button {
                isSetViewShow = true
            }label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(.gray.opacity(0.2))
                    VStack {
                        Text("사용자 설정")
                            .font(Font.system(size: 18, weight: .bold, design: .default))
                    }
                }
            }
        }
        .buttonStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button{
                    mode.wrappedValue.dismiss()
                }label: {
                    Image(systemName: "xmark")
                }
            }
        }
        .sheet(isPresented: $isSetViewShow, onDismiss: {
            if !(set == "0" || set == "") {
                isRestViewShow = true
            }
        }) {
            NumberPad(title: "세트", isShow: $isSetViewShow, numberString: $set)
        }
        .sheet(isPresented: $isRestViewShow, onDismiss: {
            if !(restTime == "0" || restTime == "") {
                self.seletedExercise?.numberOfSets = Int32(set)!
                self.seletedExercise?.restTime = Int64(restTime)!
                mode.wrappedValue.dismiss()
                isRunning = true
            }
        }) {
            NumberPad(title: "휴식", isShow: $isRestViewShow, numberString: $restTime)
        }
    }
}
