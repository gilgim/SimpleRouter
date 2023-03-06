//
//  DataType.swift
//  Router
//
//  Created by Gaea on 2023/03/06.
//

import Foundation
import RealmSwift

class RealmExercise: Object, Identifiable {
    let id = UUID()
    @Persisted(primaryKey: true) var exerciseName: String? = nil
    @Persisted var exercisePart: String? = nil
    @Persisted var symbolName: String? = nil
    @Persisted var symbolColorHex: String? = nil
    @Persisted var set: Int16 = 5
    @Persisted var restTime: Int16 = 60
}

class RealmRoutine: Object, Identifiable {
    let id = UUID()
    @Persisted(primaryKey: true) var routineName: String?
    let exercises = List<RealmExercise>()
}
func realm() -> Realm {
    do {
        let realm = try Realm()
        return realm
    }
    catch {
        fatalError("Error : \(ErrorContent.notFoundRealm)")
    }
}
