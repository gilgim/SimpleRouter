//
//  WorkOutView.swift
//  Router
//
//  Created by Gaea on 2023/03/14.
//

import SwiftUI

struct WorkOutView: View {
    @Binding var routineName: String
    @StateObject var vm: WorkOutViewModel = .init()
    var body: some View {
        ZStack {
            RunningListView(runningList: $vm.runningList, completeRunningList: $vm.completeRunningList, selectRunning: $vm.selectRunning)
                .zIndex(vm.selectRunning == nil ? 1 : 0)
                .opacity(vm.selectRunning == nil ? 1 : 0)
            if vm.selectRunning != nil {
                SelectRunningView(runningList: $vm.runningList, completeRunningList: $vm.completeRunningList, selectRunning: $vm.selectRunning)
                    .zIndex(vm.selectRunning == nil ? 0 : 1)
            }
        }
        .onAppear() {
            vm.routineName = routineName
            vm.readRoutine()
        }
        .navigationBarBackButtonHidden(vm.selectRunning == nil ? false : true)
    }
}

struct WorkOutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkOutView(routineName: .constant(""))
    }
}

struct RunningListView: View {
    @Binding var runningList: [Running]
    @Binding var completeRunningList: [Running]
    @Binding var selectRunning: Running?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(runningList, id: \.id) { running in
                    Button {
                        selectRunning = running
                    }label: {
                        Circle()
                            .overlay {
                                Text(running.name)
                            }
                    }
                }
            }
        }
    }
}

struct SelectRunningView: View {
    @Binding var runningList: [Running]
    @Binding var completeRunningList: [Running]
    @Binding var selectRunning: Running?
    
    @StateObject var vm = SelectRunningViewModel()
    
    @State var isRestRemainAlert = false
    var body: some View {
        VStack {
            if let selectRunning {
                Text("\(vm.currentSet)/\(selectRunning.set)")
                Text("\(vm.runningTime)")
                HStack {
                    TextField("무게",text: $vm.weightString)
                    if vm.weight != 0 {
                        Text("kg")
                    }
                }
                HStack {
                    TextField("개수",text: $vm.countString)
                    if vm.count != 0 {
                        Text("회")
                    }
                }
                Button {
                    if vm.isRestRemaining() {
                        self.isRestRemainAlert = true
                    }
                    else {
                        self.vm.chageRunningState()
                    }
                }label: {
                    RoundedRectangle(cornerRadius: 12)
                        .overlay {
                            Text(vm.runningState.rawValue)
                                .foregroundColor(.white)
                        }
                }
                .alert(isPresented: $isRestRemainAlert) {
                    Alert(title: Text("휴식알림"), message: Text("아직 휴식 시간이 남았습니다.\n그만 쉬시겠습니까?"), primaryButton: .destructive(Text("확인"),action: {
                        self.vm.chageRunningState()
                    }), secondaryButton: .cancel(Text("취소"), action: {
                        
                    }))
                }
                Text("\(vm.restTime)")
            }
        }
        .onAppear() {
            self.vm.runningList = self.runningList
            self.vm.runningListClosure = { value in
                self.runningList = value
            }
            
            self.vm.completeRunningList = self.completeRunningList
            self.vm.completeRunningListClosure = { value in
                self.completeRunningList = value
            }
            
            self.vm.selectRunning = self.selectRunning
            self.vm.selectRunningClosure = { value in
                self.selectRunning = value
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("취소") {
                    self.vm.selectRunning = nil
                }
                .foregroundColor(.red)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("완료") {
                    self.vm.selectRunning = nil
                }
            }
        }
    }
}
