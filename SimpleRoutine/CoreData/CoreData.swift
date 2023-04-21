//
//  CoreData.swift
//  SimpleRoutine
//
//  Created by Gaea on 2023/04/21.
//

import Foundation
import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SimpleRoutine")
        //  메모리에만 저장하여 메모리 내 저장소를 통해 테스트 및 디버깅
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "dev/null")
        }
        //  영구 저장소 로드
        container.loadPersistentStores { stopDescription, error in
            if let error {
                fatalError("↓↓↓↓↓↓↓↓ <Error> ↓↓↓↓↓↓↓↓\n\(error)")
            }
        }
    }
}
