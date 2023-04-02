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
//        RunningListView()
    }
}

struct RunningListView: View {
    @Binding var runningList: [Running]
    @Binding var completeRunningList: [Running]
    @Binding var selectRunning: Running?
    var body: some View {
        ScrollViewWrapper(content:
            HStack(spacing: 30) {
                Spacer(minLength: 30)
                //  운동 끝난 뷰
                ForEach(completeRunningList, id: \.id) { running in
                    VStack {
                        ZStack {
                            Circle()
                            Image(systemName: running.symbolName)
                                .resizable()
                                .scaledToFit()
                                .padding(80)
                                .foregroundColor(.white)
                        }
                        .frame(width: circleWidth)
                        Text("\(running.name)\n완료")
                            .foregroundColor(.black)
                            .font(Font.system(size: 24, weight: .bold, design: .rounded))
                    }
                    .foregroundColor(.gray)
                }
                //  운동 하기 전 뷰
                ForEach(runningList, id: \.id) { running in
                    Button {
                        selectRunning = running
                    }label: {
                        VStack {
                            ZStack {
                                Circle()
                                Image(systemName: running.symbolName)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(80)
                                    .foregroundColor(.white)
                            }
                            .frame(width: circleWidth)
                            Text(running.name)
                                .foregroundColor(.black)
                                .font(Font.system(size: 24, weight: .bold, design: .rounded))
                        }
                    }
                    .foregroundColor(.init(hex: running.symbolHex))
                }
                Spacer(minLength: 30)
            }
        )
    }
}
extension RunningListView {
    var circleWidth: CGFloat {
        let width = UIScreen.main.bounds.width
        let circleWidth = width - 120
        return circleWidth
    }
}

struct SelectRunningView: View {
    @Binding var runningList: [Running]
    @Binding var completeRunningList: [Running]
    @Binding var selectRunning: Running?
    
    @StateObject var vm = SelectRunningViewModel()
    
    @State var isRestRemainAlert = false
    @State var isSetRemainAlert = false
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
                    if self.vm.isSetRemaining() {
                        self.isSetRemainAlert = true
                    }
                }
            }
        }
        .alert(isPresented: $isSetRemainAlert) {
            Alert(title: Text("완료 알림"), message: Text("아직 세트가 남았습니다.\n그만하시겠습니까?"), primaryButton: .destructive(Text("확인"),action: {
                self.vm.finishRunning()
            }), secondaryButton: .cancel(Text("취소"), action: {
                
            }))
        }
    }
}
