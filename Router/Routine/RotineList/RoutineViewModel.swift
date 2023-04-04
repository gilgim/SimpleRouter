//
//  RoutineViewModel.swift
//  Router
//
//  Created by Gaea on 2023/02/27.
//

import Foundation
import Combine

class RoutineViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    @Published var routines: [Routine] = []
    
    /// alertMessage가 변경될 때 마다 뷰에서는 자동적으로 alert가 실행된다.
    @Published var alertMessage: String = "이것은 알림 기본값 입니다."
    var alertClosure: ()->() = {}
    
    @Published var modifyTargetRoutine: Routine? = nil
    var modifyTargetClosure: (Routine?) -> () = {_ in}
    
    init() {
        $alertMessage.sink { [weak self] _ in
            self?.alertClosure()
        }
        .store(in: &cancellables)
        
        $modifyTargetRoutine.sink { [weak self] value in
            self?.modifyTargetClosure(value)
        }
        .store(in: &cancellables)
    }
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
    func removeRoutine(routine: Routine) {
        guard let object = realm().object(ofType: RealmRoutine.self, forPrimaryKey: routine.routineName)
        else {
            self.alertMessage = "조회할 수 없습니다."
            return
        }
        do {
            try realm().write({
                realm().delete(object)
            })
        } catch {
            fatalError("\(error)")
        }
    }
    /// 총 세트 수 총 휴식 수 계산하는 함수
    func calcSetAndRest(routine: Routine) -> (totalSet: String, totalRest: String){
        var totalSet = 0
        var totalRest = 0
        for exercise in routine.exercises {
            totalSet += Int(exercise[2])!
            totalRest += Int(exercise[2])! * Int(exercise[3])!
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
