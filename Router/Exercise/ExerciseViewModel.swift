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
}
