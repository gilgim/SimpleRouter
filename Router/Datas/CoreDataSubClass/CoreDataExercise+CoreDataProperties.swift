//
//  CoreDataExercise+CoreDataProperties.swift
//  Router
//
//  Created by KimWooJin on 2023/02/25.
//
//

import Foundation
import CoreData


extension CoreDataExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataExercise> {
        return NSFetchRequest<CoreDataExercise>(entityName: "Exercise")
    }

    @NSManaged public var exerciseName: String?
    @NSManaged public var exercisePart: String?
    @NSManaged public var symbolColorHex: String?
    @NSManaged public var symbolName: String?
    @NSManaged public var restTime: Int16
    @NSManaged public var set: Int16
    @NSManaged public var routine: CoreDataRoutine?

}

extension CoreDataExercise : Identifiable {

}
