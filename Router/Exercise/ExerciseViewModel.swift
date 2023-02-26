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
		let fetchRequest: NSFetchRequest<CoreDataExercise> = CoreDataExercise.fetchRequest()
		let context = CoreDataManager.shared.getContext()
		self.exercises = []
		var exercise: Exercise? = nil
		do {
			let results = try context.fetch(fetchRequest)
			for item in results {
				exercise = .init(exerciseName: item.exerciseName, symbolName: item.symbolName, symbolColorHex: item.symbolColorHex, exercisePart: item.exercisePart)
				guard let exercise else {return}
				self.exercises.append(exercise)
			}
		} catch {
			fatalError("Failed to fetch data: \(error.localizedDescription)")
		}
	}
}
