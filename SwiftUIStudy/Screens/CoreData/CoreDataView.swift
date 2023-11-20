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
    
    var body: some View {
        List(vm.departments) { department in
            if let employees = department.employees?.allObjects as? [EmployeeEntity] {
                NavigationLink(destination: EmployeesView(vm: vm, department: department.name ?? "", employees: employees)) {
                    Text(department.name ?? "Unknown")
                }
            }
        }
    }
}

struct EmployeesView: View {
    let department: String
    @StateObject var vm: CoreDataViewModel
    @State var employees: [EmployeeEntity]
    
    var body: some View {
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
    ContentView()
}
