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
    }
    /// 세트 및 휴식 변경 알림
    func alertSetAndRest(exercise: Exercise) {
        //  업데이트를 위한 클로져.
        let closure = {
            self.selectExercises.append(.init())
            self.selectExercises.removeLast()
        }
        let vc = SetRestAlertViewController(closure: closure, setPublisher: exercise.setPublisher, restPublisher: exercise.restPublisher, beforeSetInt: exercise.set!, beforeRestInt: exercise.restTime!)
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        UIApplication.shared.windows.first?.rootViewController?.present(vc, animated: true)
    }
    /// 운동 삭제 함수
    func removeExercise(exercise: Exercise) {
        self.selectExercises = self.selectExercises.filter({$0 != exercise})
    }
    //   뷰에서 운동을 추가하면 뷰모델과 바인딩 되어있는 선택 운동에 세트와 휴식을 설정
    /// 운동 추가 시 운동을 선택운동 목록에 추가하는 함수
    func setSetAndRestTime() {
        guard let selectExercise = self.selectExercise else {return}
        //  기본 세트 : 5세트
        selectExercise.set = 5
        //  기본 휴식 시간 : 1분
        selectExercise.restTime = 60
        self.selectExercises.append(selectExercise)
        self.selectExercise = nil
    }
    //  루틴 생성 함수
    func createRoutine() -> Bool {
        guard self.routineName != "" else {self.alertMessage = "이름을 입력해주세요.";return false}
        guard realm().object(ofType: RealmRoutine.self, forPrimaryKey: self.routineName) == nil else {self.alertMessage = "이미 존재하는 루틴입니다.";return false}
        guard self.selectExercises.count > 0 else {self.alertMessage = "선택된 운동이 없습니다.";return false}
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
            return true
        }
        catch {
            fatalError("\(error)")
        }
    }
}
