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
	var body: some View {
		VStack {
			SearchBarView(placeholder:"루틴명", searchText: $searchText)
				.padding()
			List {
                ForEach(vm.routines, id: \.id) { routine in
                    HStack {
                        Text(routine.routineName ?? "Not")
                        ForEach(routine.exercises ?? [], id: \.self) { temp in
                            Text(temp.exerciseName ?? "Not")
                        }
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
        }
        .navigationDestination(isPresented: $isCreate) {
            RoutineCreateView()
        }
	}
}

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineView()
    }
}
