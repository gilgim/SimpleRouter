//
//  Codables.swift
//  SimpleRoutine
//
//  Created by Gaea on 2023/04/27.
//

import Foundation

struct ExerciseCodable: Codable {
    var id: UUID
    var createAt: Date
    var name: String
    var part: String
    var symbolName: String
    var colorHex: String
    var dataType: String
    
    init(exercise: Exercise, dataType: String) {
        if let id = exercise.id,
           let createAt = exercise.createAt,
           let name = exercise.name,
           let part = exercise.part,
           let symbolName = exercise.symbolName,
           let colorHex = exercise.colorHex {
            
            self.id = id
            self.createAt = createAt
            self.name = name
            self.part = part
            self.symbolName = symbolName
            self.colorHex = colorHex
            self.dataType = dataType
        }
        else {
            self.id = .init()
            self.createAt = .init()
            self.name = ""
            self.part = ""
            self.symbolName = ""
            self.colorHex = ""
            self.dataType = ""
        }
    }
}
