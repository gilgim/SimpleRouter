//
//  ExerciseViewModel.swift
//  Router
//
//  Created by Gaea on 2023/02/21.
//

import Foundation

class ExerciseViewModel: ObservableObject {
    var model: ExerciseModel? = nil
    
    public func modelValueSetting(model: ExerciseModel?) {
        self.model = model
    }
}
