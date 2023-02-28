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
	
	let context = CoreDataManager.shared.persistentContainer.viewContext
	
	let viewContext = CoreDataManager.shared.persistentContainer.viewContext
	func createExercise() {
        guard let newExercise = NSEntityDescription.insertNewObject(forEntityName: "Exercise", into: viewContext) as? CoreDataExercise else {return}
//		newExercise.setValue(self.exerciseName, forKey: "exerciseName")
//		newExercise.setValue(self.exercisePart, forKey: "exercisePart")
//		newExercise.setValue(self.symbol, forKey: "symbolName")
//		newExercise.setValue(self.hex, forKey: "symbolColorHex")
        newExercise.exerciseName = self.exerciseName
        newExercise.exercisePart = self.exercisePart
        newExercise.symbolName = self.symbol
        newExercise.symbolColorHex = self.hex
		try? context.save()
	}
}
