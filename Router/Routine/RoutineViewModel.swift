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
    
    
}
