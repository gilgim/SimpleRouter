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
}
