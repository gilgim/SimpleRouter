//
//  RoutineViewModel.swift
//  Router
//
//  Created by Gaea on 2023/02/27.
//

import Foundation
import CoreData

class RoutineViewModel: ObservableObject {
    var model: ExerciseModel? = nil
    @Published var routines: [Routine] = []
    
    func readRoutine() {
        self.routines = []
        let realmRoutines = realm().objects(RealmRoutine.self)
        for realmRoutine in realmRoutines {
            var exercises: [[String]] = []
            for exercise in realmRoutine.exercisesInfos {
                exercises.append(exercise.components(separatedBy: "&"))
            }
            let routine = Routine(routineName: realmRoutine.routineName, exercises: exercises)
            routines.append(routine)
        }
    }
}
