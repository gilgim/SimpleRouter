//
//  WorkOutView.swift
//  Router
//
//  Created by Gaea on 2023/03/06.
//

import SwiftUI

struct WorkOutView: View {
    @StateObject var vm = WorkOutViewModel()
    @Binding var routineName: String
    @State var selectWokrOut: WorkOut.WorkOutComponent?
    var body: some View {
        Group {
            if selectWokrOut == nil {
                WorkOutListView(list: $vm.workOut, selectWorkOut: $selectWokrOut)
            }
            else {
                WorkOutSelectView(selectWorkOut: $selectWokrOut)
            }
        }
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button("완료") {}
			}
		}
        .onAppear() {
            self.vm.routineName = self.routineName
            self.vm.loadWorkOutView()
        }
    }
}

struct WorkOutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkOutView(routineName: .constant(""))
    }
}

struct WorkOutListView: View {
    @Binding var list: WorkOut
    @Binding var selectWorkOut: WorkOut.WorkOutComponent?
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(list.workOuts, id:\.id) { workOut in
                    Button {
                        selectWorkOut = workOut
                    }label: {
                        VStack {
                            Circle()
                                .foregroundColor(Color(hex:workOut.symbolInfo[1]))
                                .overlay(
                                    Image(systemName:workOut.symbolInfo[0])
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                        .foregroundColor(.white)
                                )
                            Text(workOut.exerciseName)
                        }
                    }
                }
            }
            .frame(height: 100)
        }
    }
}

struct WorkOutSelectView: View {
    @Binding var selectWorkOut: WorkOut.WorkOutComponent?
    var body: some View {
        VStack {
            if let selectWorkOut {
                Circle()
                    .foregroundColor(Color(hex:selectWorkOut.symbolInfo[1]))
                    .overlay(
                        Image(systemName:selectWorkOut.symbolInfo[0])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .foregroundColor(.white)
                    )
            }
            Button {
                self.selectWorkOut = nil
            }label: {
                RoundedRectangle(cornerRadius: 13)
                    .overlay {
                        Text("끝").foregroundColor(.white)
                    }
            }
        }
    }
}
