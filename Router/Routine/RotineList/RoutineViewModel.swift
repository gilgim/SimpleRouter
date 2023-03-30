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
            totalSet += Int(exercise[1])!
            totalRest += Int(exercise[1])! * Int(exercise[2])!
        }
        let minute = totalRest/60
        let second = totalRest%60
        var addString = ""
        if second != 0 {
            addString = "\(second)초 "
        }
        return ("총 \(totalSet) 세트", "총 \(minute)분 \(addString)휴식")
    }
}
