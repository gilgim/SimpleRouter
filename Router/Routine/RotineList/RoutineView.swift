//
//  RoutineView.swift
//  Router
//
//  Created by Gaea on 2023/02/22.
//

import SwiftUI

struct RoutineView: View {
	@Environment(\.managedObjectContext) private var viewContext
    @StateObject var vm = RoutineViewModel()
	@State var searchText: String = ""
    @State var isCreate: Bool = false
    @State var isWorkOut: Bool = false
    @State var isAlert: Bool = false
    @State var userSelectRoutine: String = ""
	var body: some View {
		VStack {
            SearchBarView(placeholder:"루틴명", isKeyBoardOpen: .constant(false), searchText: $searchText)
				.padding()
			List {
                ForEach(vm.routines, id: \.id) { routine in
                    Button{
                        self.userSelectRoutine = routine.routineName
                        self.vm.alertMessage = "\(routine.routineName)를 시작하시겠습니까?"
                    }label: {
                        HStack {
                            Image(systemName: "\(routine.exercises.count).circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(routine.routineName)
                                    .font(Font.system(size: 16, weight: .regular, design: .default))
                                Text("\(vm.calcSetAndRest(routine: routine).totalSet)")
                                Text("\(vm.calcSetAndRest(routine: routine).totalRest)")
                            }
                            .font(Font.system(size: 15, weight: .semibold, design: .default))
                            .padding(10)
                            Spacer()
                            Button {
                                
                            }label: {
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .swipeActions {
                        Button {
                            vm.removeRoutine(routine: routine)
                            vm.readRoutine()
                        }label: {
                            Image(systemName: "trash.fill")
                        }
                        .tint(.red)
                        
                        Button {
                            
                        }label: {
                            Image(systemName: "square.and.pencil")
                        }
                        .tint(.green)
                    }
                }
			}
			.listStyle(InsetListStyle())
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.isCreate = true
                }label: {
					Image(systemName: "plus")
				}
			}
		}
        .onAppear() {
            self.vm.readRoutine()
            //  vm의 alert 메세지가 변화할 때 마다 alert를 자동으로 활성화 해주기 위한 로직
            self.vm.alertClosure = {
                self.isAlert = true
            }
        }
        //  MARK: Alert 관련
        .alert(vm.alertMessage.contains("시작하시겠습니까?") ? "운동 시작":"에러", isPresented: $isAlert) {
            if vm.alertMessage.contains("시작하시겠습니까?") {
                Button("취소") {}
                Button("확인") {
                    self.isWorkOut = true
                }
            }
            else {
                Text("확인")
            }
        } message: {
            Text(vm.alertMessage)
        }
        .navigationDestination(isPresented: $isCreate) {
            RoutineCreateView()
        }
        .navigationDestination(isPresented: $isWorkOut) {
            WorkOutView(routineName: $userSelectRoutine)
                .navigationTitle("\(userSelectRoutine)")
        }
	}
}

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RoutineView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
            RoutineView()
                .previewDevice(PreviewDevice.init(rawValue: "iPhone SE"))
        }
    }
}
