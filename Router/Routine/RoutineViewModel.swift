//
//  RoutineViewModel.swift
//  Router
//
//  Created by Gaea on 2023/02/27.
//

import Foundation
import CoreData

class RoutineViewModel: ObservableObject {
    var model: ExerciseModel? = nil
    @Published var routines: [Routine] = []
    
    func readExercise() {
        let fetchRequest: NSFetchRequest<CoreDataRoutine> = CoreDataRoutine.fetchRequest()
        let context = CoreDataManager.shared.getContext()
        self.routines = []
        var routine: Routine? = nil
        do {
            let results = try context.fetch(fetchRequest)
            for item in results {
//                routine = .init(routineName: item.routineName, exercises: item.)
                guard let routine else {return}
                self.routines.append(routine)
            }
        } catch {
            fatalError("Failed to fetch data: \(error.localizedDescription)")
        }
    }
}
