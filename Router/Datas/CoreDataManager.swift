//
//  Persistent.swift
//  Router
//
//  Created by Gaea on 2023/02/22.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    private init() {
		//	데이터 모델은 Datas하나만 사용할 것임.
        persistentContainer = NSPersistentContainer(name: "Datas")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
	func saveContext() {
			let context = persistentContainer.viewContext
			if context.hasChanges {
				do {
					try context.save()
				} catch {
					let nserror = error as NSError
					fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
				}
			}
	}
	func getContext() -> NSManagedObjectContext {
		return persistentContainer.viewContext
	}
}
