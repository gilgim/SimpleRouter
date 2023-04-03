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
            }
        )
        .onAppear() {
            self.vm.alertClosure = {
                self.isAlert = true
            }
        }
        .toolbar {
            if selectRunning == nil {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("중단") {
                        self.vm.alertMessage = "해당 루틴을 중단하시겠습니까?\n(저장되지 않습니다.)"
                    }
                    .foregroundColor(.red)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("종료") {
                        self.vm.alertMessage = "해당 루틴을 종료하시겠습니까?"
                    }
                }
            }
        }
        //  에러 팝업
        .alert("알림", isPresented: $isAlert, actions: {
            Button("취소", role: .cancel){}
            Button("확인", role: .destructive){
                self.mode.wrappedValue.dismiss()
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
    @Binding var runningList: [Running]
    @Binding var completeRunningList: [Running]
    @Binding var selectRunning: Running?
    
    @StateObject var vm = SelectRunningViewModel()
    @State var isAlert: Bool = false
    var body: some View {
        VStack {
            if let selectRunning {
                Text("진행: \(vm.currentSet)/\(selectRunning.set)")
                    .font(Font.system(size: 20, weight: .semibold, design: .rounded))
                ZStack {
                    Circle()
                    Image(systemName: selectRunning.symbolName)
                        .resizable()
                        .scaledToFit()
                        .padding(50)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 120)
                .foregroundColor(.init(hex: selectRunning.symbolHex))
                HStack {
                    Text("\(vm.currentSet)세트 수행시간 : \(String(format: "%.2f", vm.runningTime))")
                    Spacer()
                }
                TextField("무게",text: $vm.weightText)
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
                    
                }
            }
        }
        //  에러 팝업
        .alert("알림", isPresented: $isAlert, actions: {
            Button("취소"){}
            Button("확인"){
                if vm.alertMessage == "아직 휴식하셔야합니다.\n바로 진행하시겠습니까?" {
                    self.vm.restAction()
                }
            }
        }, message: {
            Text(vm.alertMessage)
        })
    }
}
