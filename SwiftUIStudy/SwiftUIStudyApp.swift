//
//  SwiftUIStudyApp.swift
//  SwiftUIStudy
//
//  Created by USER on 15.11.2023.
//

import SwiftUI
import Stinsen

@main
struct SwiftUIStudyApp: App {
//    @Environment(\.scenePhase) var scenePhase
    private let tokenStorage = TokenStorageImpl()
    private let stateManager = AppStateManager()
//
    
    var body: some Scene {
        WindowGroup {
                MainCoordinator()
                    .view()
                //                .onChange(of: scenePhase) { phase in
                //                    switch phase {
                //                    case .background, .inactive:
                //                        AppStateManager.shared.isActive = false
                //                    case .active:
                //                        AppStateManager.shared.isActive = true
                //                    @unknown default:
                //                        AppStateManager.shared.isActive = false
                //                    }
                //                }
                    .onAppear {
                        tokenStorage.set(token: "26792f4a-06cb-4c0c-aecd-b5ca965b50ab", key: .tokenWeather)
                    }
                    
            
        }
    }
}
