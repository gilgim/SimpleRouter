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
    @State var userSelectRoutine: String = ""
    @State var routines: [Routine] = [.init(routineName: "asdf", exercises: [["asd&5&60","asdf&5&70"]])]
	var body: some View {
		VStack {
			SearchBarView(placeholder:"루틴명", searchText: $searchText)
				.padding()
			List {
                ForEach(routines, id: \.id) { routine in
                    Button{
                        self.userSelectRoutine = routine.routineName
                        self.isWorkOut = true
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
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                .swipeActions {
                    Button {
                        
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
