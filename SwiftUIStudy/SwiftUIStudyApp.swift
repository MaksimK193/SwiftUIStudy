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
            switch scenePhase {
            case .background:
                InactiveView()
            case .inactive:
                InactiveView()
            case .active:
                ContentView()
            @unknown default:
                fatalError()
            }
        }
        
    }
}
