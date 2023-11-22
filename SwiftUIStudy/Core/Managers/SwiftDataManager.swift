//
//  SwiftDataManager.swift
//  SwiftUIStudy
//
//  Created by USER on 21.11.2023.
//

import SwiftData

final class SwiftDataManager {
    @MainActor
    static let shared = SwiftDataManager()
    
    let container: ModelContainer
    let context: ModelContext
    
    init() {
        container = try! ModelContainer(for: Department.self, Employee.self)
        context = ModelContext(container)
    }
    
    func addObject<T>(_ model: T) {
        guard let _model = model as? any PersistentModel else { return }
        context.insert(_model)
        save()
    }
    
    func fetchDepartments() -> [Department] {
        do {
            return try context.fetch(FetchDescriptor<Department>())
        } catch {
            print("Error fetching departments: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchEmployees() -> [Employee] {
        do {
            return try context.fetch(FetchDescriptor<Employee>())
        } catch {
            print("Error fetching employees: \(error.localizedDescription)")
            return []
        }
    }

    func delete<T>(_ model: T) {
        guard let _model = model as? any PersistentModel else { return }
        context.delete(_model)
    }
    
    func save() {
        try? context.save()
    }
}
