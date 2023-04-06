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
        .navigationBarBackButtonHidden(true)
    }
}

struct WorkOutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkOutView(routineName: .constant(""))
//        RunningListView()
    }
}

struct RunningListView: View {
    @Environment(\.presentationMode) var mode
    
    @Binding var runningList: [Running]
    @Binding var completeRunningList: [Running]
    @Binding var selectRunning: Running?
    
    @StateObject var vm: RunningListViewModel = .init()
    
    @State var isAlert: Bool = false
    @State var isSheetResultPage: Bool = false
    var body: some View {
        ScrollViewWrapper(content:
            HStack(spacing: 30) {
                Spacer(minLength: 30)
                //  운동 끝난 뷰
                ForEach(completeRunningList, id: \.id) { running in
                    VStack {
                        VStack(spacing:15) {
                            ZStack {
                                Circle()
                                Image(systemName: running.symbolName)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(80)
                                    .foregroundColor(.white)
                            }
                            .frame(width: circleWidth)
                            Text("\(running.name) 완료")
                                .font(Font.system(size: 24, weight: .bold, design: .rounded))
                        }
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                            VStack(alignment: .leading) {
                                Text("소요시간 :")
                                Text("완료세트 :")
                                Text("총 볼륨 :")
                                Spacer()
                            }
                        }
                        .frame(height: 150)
                    }
                    .foregroundColor(.gray)
                }
                //  운동 하기 전 뷰
                ForEach(runningList, id: \.id) { running in
                    VStack {
                        Button {
                            withAnimation {
                                selectRunning = running
                            }
                        }label: {
                            VStack(spacing:15) {
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
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                            VStack {
                                Text("세트 : \(running.set)")
                                Text("휴식 : \(running.rest)초")
                                Spacer()
                            }
                        }
                        .frame(height: 150)
                    }
                }
                Spacer(minLength: 30)
            },superViewType: .workOut
        )
        .onAppear() {
            self.vm.alertClosure = {
                self.isAlert = true
            }
            self.vm.runningList = self.runningList
            
            self.vm.$isComplete.sink { value in
                if value {
                    self.isSheetResultPage = true
                }
            }.store(in: &vm.cancellables)
            self.vm.$isDismiss.sink { value in
                if value {
                    self.mode.wrappedValue.dismiss()
                }
            }.store(in: &vm.cancellables)
        }
        .onChange(of: self.runningList, perform: { _ in
            self.vm.runningList = self.runningList
            self.vm.completeRunningList = self.completeRunningList
            if self.runningList.count == 0 {
                self.vm.finishRoutine()
            }
        })
        .toolbar {
            if selectRunning == nil {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.vm.stopRoutine()
                    }label: {
                        Image(systemName: "chevron.backward")
                        Text("중단")
                    }
                    .foregroundColor(.init(uiColor: .systemRed))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("종료") {
                        self.vm.finishRoutine()
                    }
                }
            }
        }
        .sheet(isPresented: $isSheetResultPage, onDismiss: {
            self.mode.wrappedValue.dismiss()
        }, content: {
            ResultPageView()
        })
        .alert("알림", isPresented: $isAlert, actions: {
            Button("취소", role: .cancel){}
            Button("확인", role: .destructive){
                self.vm.alertAction()
            }
        }, message: {
            Text(vm.alertMessage)
        })
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
    @Environment(\.scenePhase) var scenePhase
    
    @Binding var runningList: [Running]
    @Binding var completeRunningList: [Running]
    @Binding var selectRunning: Running?
    
    @StateObject var vm = SelectRunningViewModel()
    @State var isAlert: Bool = false
    var body: some View {
        ScrollView {
            VStack {
                if let selectRunning {
                    Text("진행: \(vm.currentSet)/\(selectRunning.set)")
                        .font(Font.system(size: 20, weight: .semibold, design: .rounded))
                    Text("\(vm.currentSet)세트 : \(self.vm.runningTimeString)")
                    
                    Button {
                        self.vm.stopWorkOut()
                    }label: {
                        ZStack {
                            Circle()
                            Image(systemName: selectRunning.symbolName)
                                .resizable()
                                .scaledToFit()
                                .padding(50)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 120)
                    .foregroundColor(.init(hex: selectRunning.symbolHex))
                    
                    Group {
                        TextField("무게",text: $vm.weightText)
                            .keyboardType(.decimalPad)
                        TextField("개수",text: $vm.countString)
                            .keyboardType(.numberPad)
                    }
                    .padding(.horizontal, 120)
                    .multilineTextAlignment(.center)
                    
                    Button {
                        vm.runningStateAction()
                    }label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 18)
                                .frame(height: 150)
                            Text(vm.runningState.rawValue + "\(vm.runningState == .rest ? vm.restTimeString : "")")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        .navigationTitle(Text(selectRunning?.name ?? "Nothing"))
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
            
            self.vm.alertClosure = {
                self.isAlert = true
            }
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                vm.scenePhase.send(.active)
            case .inactive:
//                vm.scenePhase.send(.inactive)
                break
            case .background:
                vm.scenePhase.send(.background)
            @unknown default:
                print("Unknown")
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("취소") {
                    withAnimation {
                        self.selectRunning = nil
                    }
                }
                .foregroundColor(.red)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("완료") {
                    self.vm.completeButtonAction()
                }
            }
        }
        .alert("알림", isPresented: $isAlert, actions: {
            Button("취소"){}
            Button("확인"){
                self.vm.alertAction()
            }
        }, message: {
            Text(vm.alertMessage)
        })
    }
}
