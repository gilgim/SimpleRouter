//
//  ExerciseListViewModel.swift
//  SimpleRoutine Watch App
//
//  Created by Gaea on 2023/04/28.
//

import SwiftUI
import CoreData
import Foundation

class ExerciseListViewModel: ObservableObject {
    @ObservedObject private var connectivityManager = WatchConnectivityManager.shared
    init() {
        connectivityManager.exerciseSendAction = { object in
            withAnimation {
                let fetchRequest: NSFetchRequest<Exercise> = Exercise.fetchRequest()
                let context = PersistenceController.shared.container.viewContext
                let exercise = try? JSONDecoder().decode(ExerciseCodable.self,from: object)
                if let exercise = exercise {
                    switch exercise.dataType  {
                    case "c":
                        do {
//                            let exercises = try context.fetch(fetchRequest)
//                            for exercise in exercises {
//                                context.delete(exercise)
//                            }
                            let coreExercise = Exercise(context: context)
                            coreExercise.convertExercise(codable: exercise)
                            try context.save()
                        }
                        catch {
                            
                        }
                    case "r":
                        break
                    case "u":
                        break
                    case "d":
                        do {
                            let exercises = try context.fetch(fetchRequest)
                            let target = exercises.filter({$0.id == exercise.id})
                            guard !(target.isEmpty) else {return}
                            context.delete(target[0])
                            try context.save()
                        }
                        catch {
                            
                        }
                        break
                    default:
                        break
                    }
                }
            }
        }
    }
}

