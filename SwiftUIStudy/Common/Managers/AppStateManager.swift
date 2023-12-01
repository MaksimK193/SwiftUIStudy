//
//  AppStateManager.swift
//  SwiftUIStudy
//
//  Created by USER on 28.11.2023.
//

import Foundation

class AppStateManager: ObservableObject {
    @Published var isActive = true
    
    static var shared = AppStateManager()
    
    init() {}
}
