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
    @Published var workOut: WorkOut = WorkOut(routineName: "", workOuts: [], date: "")
    
	func loadWorkOutView() {
        guard let routine = realm().object(ofType: RealmRoutine.self, forPrimaryKey: routineName) else {return}
        //  운동
        let exercises = Array(routine.exercisesName).map({$0.components(separatedBy: "&")})
        let workOutComponents = exercises.map({
            
            var workOutComponent = WorkOut.WorkOutComponent(exerciseName: $0[0], setDetail: [:], restTime: Int($0[2]) ?? 60)
            if let symbolInfo = realm().object(ofType: RealmExercise.self, forPrimaryKey: workOutComponent.exerciseName),
                let name = symbolInfo.symbolName,
                let hex = symbolInfo.symbolColorHex {
                workOutComponent.symbolInfo = [name, hex]
            }
            
            return workOutComponent
        })
        //  날짜
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.string(from: Date())
        
        self.workOut = WorkOut(routineName: self.routineName, workOuts: workOutComponents, date: date)
	}
    func createWorkOut() {
        let routine = realm().object(ofType: RealmRoutine.self, forPrimaryKey: routineName)
    }
}
