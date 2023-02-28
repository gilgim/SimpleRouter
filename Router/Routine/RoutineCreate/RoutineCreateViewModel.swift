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
//            exercise
//            newRoutine.addToExercises()
        }
        try? context.save()
    }

}
