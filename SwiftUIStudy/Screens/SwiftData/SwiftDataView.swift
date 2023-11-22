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
                Button(action: {
                    let dep1 = Department(id: Int(id) ?? 1, name: departmentName, employees: [])
                    viewModel.addObject(dep1)
                }) {
                    Label("Add Item", systemImage: "plus")
                }
            }
            .padding()
            List {
                ForEach(viewModel.departments) { dep in
                    NavigationLink {
                        SwiftDataEmployeesView(department: dep, vm: viewModel)
                    } label: {
                        Text(dep.name)
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
            Button(action: {
                let emp = Employee(id: Int(id) ?? 1, name: employeeName)
                emp.department = department
                vm.addObject(emp)
            }) {
                Label("Add Item", systemImage: "plus")
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
