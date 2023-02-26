//
//  CoreDataRoutine+CoreDataProperties.swift
//  Router
//
//  Created by KimWooJin on 2023/02/25.
//
//

import Foundation
import CoreData


extension CoreDataRoutine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataRoutine> {
        return NSFetchRequest<CoreDataRoutine>(entityName: "Routine")
    }

    @NSManaged public var routineName: String?
    @NSManaged public var exercises: CoreDataExercise?

}

extension CoreDataRoutine : Identifiable {

}
