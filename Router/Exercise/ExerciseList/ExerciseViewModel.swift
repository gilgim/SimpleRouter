//
//  ExerciseViewModel.swift
//  Router
//
//  Created by Gaea on 2023/02/21.
//

import Foundation
import Combine

class ExerciseViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    /// alertMessage가 변경될 때 마다 뷰에서는 자동적으로 alert가 실행된다.
    @Published var alertMessage: String = "이것은 알림 기본값 입니다."
    var alertClosure: ()->() = {}
    
	@Published var exercises: [Exercise] = []
    @Published var modifyTargetExercise: Exercise? = nil
    var modifyTargetClosure: (Exercise?) -> () = {_ in}
    init() {
        $alertMessage.sink { [weak self] _ in
            self?.alertClosure()
        }
        .store(in: &cancellables)
        
        $modifyTargetExercise.sink { [weak self] exercise in
            self?.modifyTargetClosure(exercise)
        }
        .store(in: &cancellables)
    }
    func readExercise() {
        self.exercises = []
        let realmExercise = realm().objects(RealmExercise.self)
        let exercises = realmExercise.map({
            let exercise = Exercise(exerciseName: $0.exerciseName, symbolName: $0.symbolName, symbolColorHex: $0.symbolColorHex, exercisePart: $0.exercisePart)
            return exercise
        })
        self.exercises = exercises.map({$0})
    }
    func deleteExercise() {
        guard let modifyTargetExercise else {alertMessage = "삭제할 수 없습니다.";return}
        guard let object = realm().object(ofType: RealmExercise.self, forPrimaryKey: modifyTargetExercise.exerciseName) else {alertMessage = "조회 할 수 없습니다.";return}
        do {
            try realm().write({
                realm().delete(object)
            })
        } catch {
            fatalError("\(error)")
        }
        self.modifyTargetExercise = nil
    }
}
