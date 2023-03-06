//
//  WorkOutViewModel.swift
//  Router
//
//  Created by Gaea on 2023/03/06.
//

import Foundation

class WorkOutViewModel: ObservableObject {
    @Published var routineName: String = ""
	@Published var weight: String = ""
	@Published var count: String = ""
	@Published var workOutComponent: WorkOut = .init(routineName: "", workOuts: [], date: "")
	func startWorkOut() {
		
	}
    func createWorkOut() {
        let routine = realm().object(ofType: RealmRoutine.self, forPrimaryKey: routineName)
    }
}
