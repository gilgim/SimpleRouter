//
//  WorkOutViewModel.swift
//  Router
//
//  Created by Gaea on 2023/03/06.
//

import Foundation

class WorkOutViewModel: ObservableObject {
    @Published var routineName: String = ""
    func createWorkOut() {
        let routine = realm().object(ofType: RealmRoutine.self, forPrimaryKey: routineName)
        
    }
}
