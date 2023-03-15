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
    //  중복 이름 방지를 위해 운동이름은 고유값으로 설정해준다.
    @Persisted(primaryKey: true) var exerciseName: String
    @Persisted var exercisePart: String
    @Persisted var symbolName: String 
    @Persisted var symbolColorHex: String
}

class RealmRoutine: Object, Identifiable {
    let id = UUID()
    @Persisted(primaryKey: true) var routineName: String
    @Persisted var exercisesInfos = List<String>()
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
