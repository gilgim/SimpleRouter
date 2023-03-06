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
}

class RealmRoutine: Object, Identifiable {
    let id = UUID()
    @Persisted(primaryKey: true) var routineName: String?
    @Persisted var exercisesName = List<String>()
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
