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
	
}
