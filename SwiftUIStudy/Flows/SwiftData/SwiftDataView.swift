//
//  SwiftDataView.swift
//  SwiftUIStudy
//
//  Created by USER on 21.11.2023.
//

import SwiftUI
import YandexMobileMetrica

struct SwiftDataView: View {
    @State private var viewModel = SwiftDataViewModel()
    @State private var id: String = ""
    @State private var departmentName: String = ""
    @ObservedObject var stateManager: AppStateManager
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    TextField(L10n.SwiftData.TextField.id, text: $id)
                        .textFieldStyle(.roundedBorder)
                    TextField(L10n.SwiftData.TextField.name, text: $departmentName)
                        .textFieldStyle(.roundedBorder)
                    Button(L10n.SwiftData.Button.addItem, systemImage: "plus") {
                        let department = Department(id: Int(id) ?? 1, name: departmentName, employees: [])
                        viewModel.addObject(department)
                    }
                    .accessibilityIdentifier("swiftDataAddButton")
                }
                .padding()
                List {
                    ForEach(viewModel.departments) { department in
                        NavigationLink {
                            SwiftDataEmployeesView(department: department, vm: viewModel, stateManager: stateManager)
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
            InactiveView()
                .opacity(stateManager.isActive ? 0 : 100)
        }
        .onAppear {
            YMMYandexMetrica.reportEvent("SwiftDataScreen opened")
        }
    }
}

struct SwiftDataEmployeesView: View {
    @State var department: Department
    @State var vm: SwiftDataViewModel
    @State private var id: String = ""
    @State private var employeeName: String = ""
    @ObservedObject var stateManager: AppStateManager
    
    var body: some View {
        ZStack {
            HStack {
                TextField(L10n.SwiftData.TextField.id, text: $id)
                    .textFieldStyle(.roundedBorder)
                TextField(L10n.SwiftData.TextField.name, text: $employeeName)
                    .textFieldStyle(.roundedBorder)
                Button(L10n.SwiftData.Button.addItem, systemImage: "plus") {
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
            InactiveView()
                .opacity(stateManager.isActive ? 0 : 100)
        }
    }
}

#Preview {
    SwiftDataView(stateManager: AppStateManager.shared)
}
