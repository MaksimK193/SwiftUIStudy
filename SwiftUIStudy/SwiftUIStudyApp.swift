//
//  SwiftUIStudyApp.swift
//  SwiftUIStudy
//
//  Created by USER on 15.11.2023.
//

import SwiftUI

@main
struct SwiftUIStudyApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView(stateManager: AppStateManager.shared)
                .onChange(of: scenePhase) { phase in
                    switch phase {
                    case .background, .inactive:
                        AppStateManager.shared.isActive = false
                    case .active:
                        AppStateManager.shared.isActive = true
                    @unknown default:
                        AppStateManager.shared.isActive = false
                    }
                }
        }
    }
}
