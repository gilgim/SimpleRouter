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
	var body: some View {
		VStack {
			SearchBarView(placeholder:"루틴명", searchText: $searchText)
				.padding()
			List {
                ForEach(vm.routines, id: \.id) { routine in
                    Button(routine.routineName) {
                            self.userSelectRoutine = routine.routineName
                            self.isWorkOut = true
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
        RoutineView()
    }
}
