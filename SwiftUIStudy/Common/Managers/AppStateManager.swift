//
//  AppStateManager.swift
//  SwiftUIStudy
//
//  Created by USER on 28.11.2023.
//

import Foundation

class AppStateManager: ObservableObject {
    @Published var isActive = false
    
    static var shared = AppStateManager()
    
    private init() {}
}
