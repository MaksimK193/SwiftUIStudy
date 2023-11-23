//
//  CoreDataViewModel.swift
//  SwiftUIStudy
//
//  Created by USER on 20.11.2023.
//

import Foundation
import CoreData

enum entityName: String {
    case department
    case employee
    
    var string: String {
        switch self {
        case .department:
            return "DepartmentEntity"
        case .employee:
            return "EmployeeEntity"
        }
    }
}

class CoreDataViewModel: ObservableObject {
    let coreDataManager = CoreDataManager.shared
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getEntity(entity: .department)
        getEntity(entity: .employee)
    }
    
    func getEntity(entity: entityName) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity.string)
        do {
            switch entity {
            case .department:
                departments = try coreDataManager.context.fetch(request) as [DepartmentEntity]
            case .employee:
                employees = try coreDataManager.context.fetch(request) as [EmployeeEntity]
            }
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
    
    func addDepartment(name: String, id: UUID? = UUID()) {
        let newDepartment = DepartmentEntity(context: coreDataManager.context)
        newDepartment.id = id
        newDepartment.name = name
        save()
    }
    
    func addEmployee(name: String, id: UUID? = UUID(), departmentName: String) {
        let newEmployee = EmployeeEntity(context: coreDataManager.context)
        newEmployee.id = id
        newEmployee.name = name
        if let i = departments.firstIndex(where: { $0.name == departmentName }) {
            departments[i].addToEmployees(newEmployee)
        }
        save()
    }
    
    func delete(_ object: NSManagedObject) {
        coreDataManager.delete(object)
        save()
    }
    
    func save() {
        departments.removeAll()
        employees.removeAll()
        coreDataManager.save()
        getEntity(entity: .department)
        getEntity(entity: .employee)
    }
}
