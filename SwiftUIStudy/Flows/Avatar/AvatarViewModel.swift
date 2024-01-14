//
//  AvatarViewModel.swift
//  SwiftUIStudy
//
//  Created by USER on 12.01.2024.
//

import Foundation
import CoreData

class AvatarViewModel: ObservableObject {
    let coreDataManager = CoreDataManager.shared
    @Published var avatars: [AvatarEntity] = []
    
    init() {
        coreDataManager.setupDataModel(name: .Avatars)
        getEntity()
    }
    
    func getEntity() {
        let request = NSFetchRequest<AvatarEntity>(entityName: "AvatarEntity")
        do {
            avatars = try coreDataManager.context.fetch(request)
        } catch let error {
            print("Error fetching entity: \(error.localizedDescription)")
        }
    }
    
    func reset(entity: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try coreDataManager.context.execute(deleteRequest)
            try coreDataManager.context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func addAvatar(name: String, id: UUID? = UUID()) {
        let newDepartment = DepartmentEntity(context: coreDataManager.context)
        newDepartment.id = id
        newDepartment.name = name
        save()
    }
    
    func delete(_ object: NSManagedObject) {
        coreDataManager.delete(object)
        save()
    }
    
    func save() {
        coreDataManager.save()
        getEntity()
    }
}

