//
//  RoutineCreateViewModel.swift
//  Router
//
//  Created by Gaea on 2023/02/27.
//

import Foundation
import CoreData
import RealmSwift

class RoutineCreateViewModel: ObservableObject {
    @Published var selectExercises: [Exercise] = []
    @Published var routineName: String = ""
    
    //  빈값이 무조건 없다는 가정으로 한다.
    func createRoutine() {
        let realmRoutine = RealmRoutine()
        realmRoutine.routineName = self.routineName
        let listExerciseName = List<String>()
        listExerciseName.append(objectsIn: self.selectExercises.map({
            let exerciseString = "\($0.exerciseName)&\($0.set ?? 5)&\($0.restTime ?? 60)"
            return exerciseString
        }))
        realmRoutine.exercisesInfos = listExerciseName
        do {
            try realm().write({
                realm().add(realmRoutine)
            })
        }
        catch {
            fatalError("\(error)")
        }
    }
}
