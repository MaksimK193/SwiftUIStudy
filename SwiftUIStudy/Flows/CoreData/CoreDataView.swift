//
//  CoreDataView.swift
//  SwiftUIStudy
//
//  Created by USER on 16.11.2023.
//

import CoreData
import SwiftUI

struct CoreDataView: View {
    @StateObject var vm = CoreDataViewModel()
    @ObservedObject var stateManager: AppStateManager
    
    var body: some View {
        ZStack {
            List(vm.departments) { department in
                if let employees = department.employees?.allObjects as? [EmployeeEntity] {
                    NavigationLink(destination: EmployeesView(department: department.name ?? "", vm: vm, employees: employees, stateManager: stateManager)) {
                        Text(department.name ?? "Unknown")
                    }
                }
            }
            Button("Add departments") {
                // Add entities for testing
                vm.addDepartment(name: "Backend")
                vm.addDepartment(name: "Fromtend")
                vm.addDepartment(name: "QA")
                vm.addDepartment(name: "Design")
            }
            .accessibilityIdentifier("coreDataAddButton")
            InactiveView()
                .opacity(stateManager.isActive ? 0 : 100)
        }
    }
}

struct EmployeesView: View {
    let department: String
    @StateObject var vm: CoreDataViewModel
    @State var employees: [EmployeeEntity]
    @ObservedObject var stateManager: AppStateManager
    
    var body: some View {
        ZStack {
            List {
                ForEach(employees) {employee in
                    if !employee.isFault {
                        EmployeeRowView(name: employee.name)
                    }
                }
                .onDelete(perform: { indexSet in
                    guard let index = indexSet.first else { return }
                    vm.delete(employees[index])
                })
            }
            .navigationTitle(department)
            Button("Add entity") {
                // Add entities for testing
                if department == "Backend" {
                    vm.addEmployee(name: "Илья", departmentName: department)
                    vm.addEmployee(name: "Олег", departmentName: department)
                    vm.addEmployee(name: "Сергей", departmentName: department)
                }
                if department == "Frontend" {
                    vm.addEmployee(name: "Ислам", departmentName: department)
                    vm.addEmployee(name: "Беслан", departmentName: department)
                    vm.addEmployee(name: "Максим", departmentName: department)
                    vm.addEmployee(name: "Сергей", departmentName: department)
                    vm.addEmployee(name: "Александр", departmentName: department)
                    vm.addEmployee(name: "Анна", departmentName: department)
                }
                if department == "QA" {
                    vm.addEmployee(name: "Юлия", departmentName: department)
                    vm.addEmployee(name: "Сергей", departmentName: department)
                    vm.addEmployee(name: "Виктория", departmentName: department)
                    vm.addEmployee(name: "Константин", departmentName: department)
                }
                if department == "Design" {
                    vm.addEmployee(name: "Никита", departmentName: department)
                    vm.addEmployee(name: "Юлия", departmentName: department)
                }
            }
            InactiveView()
                .opacity(stateManager.isActive ? 0 : 100)
        }
    }
}

struct EmployeeRowView: View {
    var name: String?
    
    var body: some View {
        HStack(alignment: .center) {
            Text(name ?? "Unknown")
        }
    }
}

#Preview {
    ContentView(stateManager: AppStateManager.shared)
}
