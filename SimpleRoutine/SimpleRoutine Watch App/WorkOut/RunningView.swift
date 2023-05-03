//
//  RunningView.swift
//  SimpleRoutine Watch App
//
//  Created by Gaea on 2023/05/03.
//

import SwiftUI

struct RunningView: View {
    @Environment(\.presentationMode) var mode
    @StateObject var vm = RunningViewModel()
    @State var exercise: Exercise
    @State var isSave: Bool = false
    var body: some View {
        VStack {
            Text("\(exercise.numberOfSets)")
            Text("\(exercise.restTime)")
        }
        .navigationBarBackButtonHidden(true)
        .alert("알림", isPresented: $vm.isAlert, actions: {
            Button{
                if isSave {
                    
                }
                mode.wrappedValue.dismiss()
            }label: {
                Text("확인")
            }
            Button {
                
            } label: {
                Text("취소")
            }
        }, message: {
            Text(vm.alertMessage)
        })
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button{
                    vm.alertEvent.send("운동을 종료하시겠습니까?")
                }label: {
                    Image(systemName: "chevron.backward")
                }
            }
        }
    }
}

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView(exercise: .init())
    }
}
