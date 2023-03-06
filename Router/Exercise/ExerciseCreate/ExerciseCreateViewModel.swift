//
//  ExerciseCreateViewModel.swift
//  Router
//
//  Created by KimWooJin on 2023/02/25.
//

import Foundation
import CoreData

class ExerciseCreateViewModel: ObservableObject {
	@Published var symbol: String = "figure.walk"
	@Published var hex: String = ""
	@Published var exerciseName: String = ""
	@Published var exercisePart: String = ""
	
    func createExercise() {
        let realmExercise = RealmExercise()
        realmExercise.exerciseName = self.exerciseName
        realmExercise.exercisePart = self.exercisePart
        realmExercise.symbolName = self.symbol
        realmExercise.symbolColorHex = self.hex
        do {
            try realm().write({
                realm().add(realmExercise)
            })
        }
        catch {
            fatalError("\(error)")
        }
    }
}
