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
    private let tokenStorage = TokenStorageImpl()
    
    var body: some Scene {
        WindowGroup {
                MainCoordinator()
                    .view()
                    .onAppear {
                        tokenStorage.set(token: "26792f4a-06cb-4c0c-aecd-b5ca965b50ab", key: .tokenWeather)
                    }
                    
            
        }
    }
}
