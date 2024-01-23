//
//  CoreDataManager.swift
//  SwiftUIStudy
//
//  Created by USER on 20.11.2023.
//

import CoreData

enum CoreDataModels: String {
    case Coordinates
    case CoreDataStudy
    case Avatars
    case Countries
}

final class CoreDataManager {
    static let shared = CoreDataManager()
    var container: NSPersistentContainer
    var context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        context = container.viewContext
    }
    
    func setupDataModel(name: CoreDataModels) {
        container = NSPersistentContainer(name: name.rawValue)
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        context = container.viewContext
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
    
    func save() {
        try? context.save()
    }
}
