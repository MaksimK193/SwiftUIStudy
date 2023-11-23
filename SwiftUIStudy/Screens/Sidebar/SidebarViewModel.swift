//
//  SidebarViewModel.swift
//  SwiftUIStudy
//
//  Created by USER on 16.11.2023.
//

import Foundation

enum TaskScreens: String {
    case coreData = "Core Data"
    case swiftData = "Swift Data"
}

class SidebarViewModel: ObservableObject {
    @Published var screens: [SidebarListModel] = [SidebarListModel(id: 0, screen: .coreData),
                                                  SidebarListModel(id: 1, screen: .swiftData)]
}
