//
//  SwiftDataViewModel.swift
//  SwiftUIStudy
//
//  Created by USER on 21.11.2023.
//

import Foundation

@Observable
final class SwiftDataViewModel {
    private let swiftDataManager: SwiftDataManager
    
    var departments: [Department]
    var employees: [Employee]
    
    init(swiftDataManager: SwiftDataManager = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
        departments = swiftDataManager.fetchDepartments()
        employees = swiftDataManager.fetchEmployees()
    }
    
    func addObject<T>(_ model: T) {
        swiftDataManager.addObject(model)
        departments = swiftDataManager.fetchDepartments()
    }
    
    func remove<T>(_ model: T) {
        swiftDataManager.delete(model)
    }
}
