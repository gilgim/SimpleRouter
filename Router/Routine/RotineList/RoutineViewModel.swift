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
    
    /// 총 세트 수 총 휴식 수 계산하는 함수
    func calcSetAndRest(routine: Routine) -> (totalSet: String, totalRest: String){
        var totalSet = 0
        var totalRest = 0
        for exercise in routine.exercises {
            let setAndRestArray = exercise.map({[Int($0.components(separatedBy: "&")[1]) ?? 5, Int($0.components(separatedBy: "&")[2]) ?? 60 ]})
            for component in setAndRestArray {
                totalSet += component[0]
                totalRest += component[1] * (component[0])
            }
        }
        let minute = totalRest/60
        let second = totalRest%60
        return ("총 \(totalSet) 세트", "총 \(minute)분 \(second)초 휴식")
    }
}
