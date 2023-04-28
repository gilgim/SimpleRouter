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
    @ObservedObject private var connectivityManager = WatchConnectivityManager.shared
    @State var selectExercise: Exercise? = nil
    @State var isRunning = false
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
                        ZStack {
                            Text("기본세트")
                                .fontWeight(.bold)
                        }
                    }
                }
                .navigationDestination(isPresented: $isRunning) {
                    RunningView(selectExercise: selectExercise)
                }
            }
        }
        //  임시로직
        else {
            ScrollView(.horizontal) {
                HStack {
                    Text("목록1")
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
struct RunningView: View {
    @ObservedObject private var connectivityManager = WatchConnectivityManager.shared
    @State var selectExercise: Exercise
    @StateObject var vm: RunningViewModel = .init()
    @State var isStart: Bool = false
    var body: some View {
        VStack {
            Text(selectExercise.name!)
                .fontWeight(.bold)
                .padding(.top,10)
            Spacer()
            Text("\(vm.runningTime)")
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
    }
}
struct WorkOutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkOutView()
    }
}
