//
//  SwiftDataView.swift
//  SwiftUIStudy
//
//  Created by USER on 21.11.2023.
//

import SwiftUI

struct SwiftDataView: View {
    @State private var viewModel = SwiftDataViewModel()
    @State private var id: String = ""
    @State private var departmentName: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("id", text: $id)
                    .textFieldStyle(.roundedBorder)
                TextField("name", text: $departmentName)
                    .textFieldStyle(.roundedBorder)
                Button("Add Item", systemImage: "plus"){
                    let department = Department(id: Int(id) ?? 1, name: departmentName, employees: [])
                    viewModel.addObject(department)
                }
            }
            .padding()
            List {
                ForEach(viewModel.departments) { department in
                    NavigationLink {
                        SwiftDataEmployeesView(department: department, vm: viewModel)
                    } label: {
                        Text(department.name)
                    }
                }
                .onDelete(perform: { offsets in
                    for index in offsets {
                        viewModel.remove(viewModel.departments[index])
                    }
                })
            }
        }
    }
}

struct SwiftDataEmployeesView: View {
    @State var department: Department
    @State var vm: SwiftDataViewModel
    @State private var id: String = ""
    @State private var employeeName: String = ""
    
    var body: some View {
        HStack {
            TextField("id", text: $id)
                .textFieldStyle(.roundedBorder)
            TextField("name", text: $employeeName)
                .textFieldStyle(.roundedBorder)
            Button("Add Item", systemImage: "plus") {
                let employee = Employee(id: Int(id) ?? 1, name: employeeName)
                employee.department = department
                vm.addObject(employee)
            }
        }
        .padding()
        List {
            ForEach(department.employees) {employee in
                EmployeeRowView(name: employee.name)
            }
            .onDelete(perform: { indexSet in
                guard let index = indexSet.first else { return }
                vm.remove(department.employees[index])
            })
        }
        .navigationTitle(department.name)
    }
}

#Preview {
    SwiftDataView()
}
