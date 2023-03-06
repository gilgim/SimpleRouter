//
//  ExerciseViewModel.swift
//  Router
//
//  Created by Gaea on 2023/02/21.
//

import Foundation
import CoreData

class ExerciseViewModel: ObservableObject {
    var model: ExerciseModel? = nil
	@Published var exercises: [Exercise] = []
    public func modelValueSetting(model: ExerciseModel?) {
        self.model = model
    }
    func readExercise() {
        let realmExercise = realm().objects(RealmExercise.self)
        let exercises = realmExercise.map({
            let exercise = Exercise(exerciseName: $0.exerciseName, symbolName: $0.symbolName, symbolColorHex: $0.symbolColorHex, exercisePart: $0.exercisePart)
            return exercise
        })
        self.exercises = exercises.map({$0})
    }
}
