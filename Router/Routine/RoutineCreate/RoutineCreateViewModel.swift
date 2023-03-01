//
//  RoutineCreateViewModel.swift
//  Router
//
//  Created by Gaea on 2023/02/27.
//

import Foundation
import CoreData

class RoutineCreateViewModel: ObservableObject {
    @Published var selectExercises: [Exercise] = []
    @Published var routineName: String = ""
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let viewContext = CoreDataManager.shared.persistentContainer.viewContext
    
    func createRoutine() {
        guard let newRoutine = NSEntityDescription.insertNewObject(forEntityName: "Routine", into: viewContext) as? CoreDataRoutine else {return}
        newRoutine.routineName = self.routineName
        for exercise in selectExercises {
			guard let coreExercise = NSEntityDescription.insertNewObject(forEntityName: "Exercise", into: viewContext) as? CoreDataExercise else {return}
			coreExercise.exerciseName = exercise.exerciseName
			coreExercise.exercisePart = exercise.exercisePart
			coreExercise.symbolName = exercise.symbolName
			coreExercise.symbolColorHex = exercise.symbolColorHex
			coreExercise.set = exercise.set ?? 5
			coreExercise.restTime = exercise.restTime ?? 60
			
			newRoutine.addToExercises(coreExercise)
        }
        try? context.save()
    }

}
