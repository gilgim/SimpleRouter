//
//  WorkOutView.swift
//  SimpleRoutine Watch App
//
//  Created by Gaea on 2023/04/21.
//

import SwiftUI
import Combine
import CoreData
import WatchConnectivity

struct WorkOutView: View {
    @Environment(\.presentationMode) var mode
    @State var selectExercise: Exercise? = nil
    @State var isRunning = false
    @State var isCustom = false
    @State var customSet: String = ""
    @State var customRest: String = ""
    var body: some View {
        if let selectExercise {
            ScrollView {
                VStack {
                    Text("세트와 휴식을 설정해주세요.")
                    Button {
                        selectExercise.restTime = 90
                        selectExercise.numberOfSets = 5
                        isRunning.toggle()
                    }label: {
                        VStack {
                            Text("기본세트")
                                .fontWeight(.bold)
                            Text("5세트 및 1분 30초 휴식입니다.")
                                .font(Font.system(size: 13, weight: .regular, design: .default))
                        }
                    }
                    NavigationLink(destination: NumberPad(numberString: .constant(""))) {
                        Text("Open Modal View")
                    }
                    .isDetailLink(false)
                }
                .sheet(isPresented: $isRunning,onDismiss: {
                    mode.wrappedValue.dismiss()
                }) {
                    RunningView(selectExercise: selectExercise)
                }
                .fullScreenCover(isPresented: $isCustom, content: {
                    NumberPad(numberString: .constant(""))
                        .navigationBarBackButtonHidden()
                })
            }
        }
        //  임시로직
        else {
            ScrollView(.horizontal) {
                HStack {
                    Text("01234")
                        .font(.system(.headline, design: .rounded))
                    Text("목록2")
                    Text("목록3")
                    Text("목록4")
                    Text("목록5")
                    Text("목록6")
                }
            }
        }
    }
}
struct CustomSetSelectView: View {
    @Binding var set: String
    @Binding var rest: String
    var body: some View {
        VStack {
            TextField("세트", text: $set)
            TextField("휴식시간", text: $rest)
            
        }
    }
}
struct RunningView: View {
    @Environment(\.presentationMode) var mode
    
    @StateObject var vm: RunningViewModel = .init()
    @State var selectExercise: Exercise
    @State var isStart: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text(vm.runningTimeText)
                    .fontDesign(.monospaced)
                    .fontWeight(.black)
                    .fontWidth(.init(30))
                    .foregroundColor(.yellow)
                Spacer()
            }
            
            Spacer()
            Button {
                isStart.toggle()
                if isStart {
                    vm.runningStart()
                }
                else {
                    vm.runningStop()
                }
            }label: {
                Text(isStart ? "완료" : "시작")
            }
            .tint(.blue)
        }
        .onAppear() {
            self.vm.exercise = selectExercise
        }
        .navigationTitle(selectExercise.name!)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    vm.alertEvent.send("운동을 취소하시겠습니까?")
                }label: {
                    Image(systemName: "arrow.backward")
                }
            }
        }
        .alert("알림", isPresented: $vm.isAlert) {
            Button("확인") {
                mode.wrappedValue.dismiss()
            }
            Button("취소") {}
        }message: {
            Text(vm.alertMessage)
        }
    }
}
struct WorkOutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkOutView()
    }
}
