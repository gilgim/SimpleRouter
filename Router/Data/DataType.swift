//
//  DataType.swift
//  Router
//
//  Created by Gaea on 2023/03/06.
//

import Foundation
import RealmSwift

//  같은 운동이여도 부위별로 다를 수 있음.
class RealmExercise: Object, Identifiable {
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var exerciseName: String
    @Persisted var exercisePart: String
    @Persisted var symbolName: String 
    @Persisted var symbolColorHex: String
}

class RealmRoutine: Object, Identifiable {
    let id = UUID()
    @Persisted(primaryKey: true) var routineName: String
    @Persisted var exercisesInfos = List<String>()
}

class RealmWorkOut: Object, Identifiable {
    let id = UUID()
    @Persisted var completeRoutineName: String
    @Persisted var setInfo = List<String>()
    @Persisted var completeDate: String
    
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
