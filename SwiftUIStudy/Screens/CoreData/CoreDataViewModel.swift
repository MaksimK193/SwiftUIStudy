//
//  CoreDataViewModel.swift
//  SwiftUIStudy
//
//  Created by USER on 20.11.2023.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    let coreDataManager = CoreDataManager.shared
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getDepartments()
        getEmployees()
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
            departments = try coreDataManager.context.fetch(request)
        } catch let error {
            print("Error fetching departments: \(error.localizedDescription)")
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
            employees = try coreDataManager.context.fetch(request)
        } catch let error {
            print("Error fetching departments: \(error.localizedDescription)")
        }
    }
    
    func reset(entity: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try coreDataManager.context.execute(deleteRequest)
            try coreDataManager.context.save()
        }
        catch
        {
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
        departments.map {
            if $0.name == departmentName {
                $0.addToEmployees(newEmployee)
            }
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
        getDepartments()
        getEmployees()
    }
}
