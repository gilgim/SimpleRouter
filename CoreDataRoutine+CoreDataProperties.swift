//
//  CoreDataRoutine+CoreDataProperties.swift
//  Router
//
//  Created by Gaea on 2023/02/27.
//
//

import Foundation
import CoreData


extension CoreDataRoutine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataRoutine> {
        return NSFetchRequest<CoreDataRoutine>(entityName: "Routine")
    }

    @NSManaged public var routineName: String?
    @NSManaged public var exercises: NSOrderedSet?

}

// MARK: Generated accessors for exercises
extension CoreDataRoutine {

    @objc(insertObject:inExercisesAtIndex:)
    @NSManaged public func insertIntoExercises(_ value: CoreDataExercise, at idx: Int)

    @objc(removeObjectFromExercisesAtIndex:)
    @NSManaged public func removeFromExercises(at idx: Int)

    @objc(insertExercises:atIndexes:)
    @NSManaged public func insertIntoExercises(_ values: [CoreDataExercise], at indexes: NSIndexSet)

    @objc(removeExercisesAtIndexes:)
    @NSManaged public func removeFromExercises(at indexes: NSIndexSet)

    @objc(replaceObjectInExercisesAtIndex:withObject:)
    @NSManaged public func replaceExercises(at idx: Int, with value: CoreDataExercise)

    @objc(replaceExercisesAtIndexes:withExercises:)
    @NSManaged public func replaceExercises(at indexes: NSIndexSet, with values: [CoreDataExercise])

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: CoreDataExercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: CoreDataExercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSOrderedSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSOrderedSet)

}

extension CoreDataRoutine : Identifiable {

}
