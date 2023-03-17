//
//  RoutineCreateViewModel.swift
//  Router
//
//  Created by Gaea on 2023/02/27.
//

import Foundation
import Combine
import RealmSwift

class RoutineCreateViewModel: ObservableObject {
    @Published var routineName: String = ""
    
    private var cancelables = Set<AnyCancellable>()
    
    @Published var alertMessage: String = "이것은 알림 기본값 입니다."
    var alertClosure: ()->() = {}
    
    @Published var selectExercises: [Exercise] = []
    var selectExercisesClosure: ([Exercise])->() = {_ in}
    
    @Published var selectExercise: Exercise? = nil
    var selectExerciseClosure: (Exercise?)->() = {_ in}
    
    @Published var isSetRestAlert: Bool = false
    var setRestAlertClosure: (Bool) -> () = {_ in}
    //  뷰와 뷰모델 데이터와의 바인딩 처리를 위한 초기화
    init() {
        $alertMessage.sink { [weak self] _ in
            self?.alertClosure()
        }
        .store(in: &cancelables)
        
        $selectExercises.sink { [weak self] exercises in
            self?.selectExercisesClosure(exercises)
        }
        .store(in: &cancelables)
        
        $selectExercise.sink { [weak self] exercise in
            self?.selectExerciseClosure(exercise)
        }
        .store(in: &cancelables)
        
        $isSetRestAlert.sink { [weak self] value in
            self?.setRestAlertClosure(value)
        }
        .store(in: &cancelables)
    }
    /// 세트 수와 휴식 시간을 설정하는 sheet 팝업 함수
    func setRestSettingAlert() {
        self.isSetRestAlert = true
    }
    /// 운동 추가 시 세트 개수와 휴식 시간을 설정하는 함수
    func setSetAndRestTime() {
        guard var selectExercise = self.selectExercise else {return}
        //  기본 세트 : 5세트
        selectExercise.set = 5
        //  기본 휴식 시간 : 1분
        selectExercise.restTime = 60
        self.selectExercises.append(selectExercise)
        self.selectExercise = nil
    }
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
