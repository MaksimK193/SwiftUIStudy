//
//  SwiftDataEntities.swift
//  SwiftUIStudy
//
//  Created by USER on 21.11.2023.
//

import Foundation
import SwiftData

@available(iOS 17, *)
@Model
final class Department {
    @Attribute (.unique) var ident: Int
    var name: String
    @Relationship(inverse: \Employee.department) var employees: [Employee]
    
    init(id: Int, name: String = "", employees: [Employee] = []) {
        self.ident = id
        self.name = name
        self.employees = employees
    }
}
@available(iOS 17, *)
@Model
final class Employee {
    @Attribute (.unique) var id: Int
    var name: String
    var department: Department?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
