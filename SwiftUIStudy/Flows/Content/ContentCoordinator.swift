//
//  ContentCoordinator.swift
//  SwiftUIStudy
//
//  Created by USER on 30.11.2023.
//

import Foundation
import SwiftUI

import Stinsen

final class ContentCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initial: \ContentCoordinator.start)
    
    @Root var start = makeStart
    @Route(.push) var swiftData = makeSwiftData
    @Route(.push) var coreData = makeCoreData
    @Route(.push) var weather = makeWeather
    @Route(.push) var photoCompression = makePhotoCompression
    
}

extension ContentCoordinator {
    @ViewBuilder func makeCoreData() -> some View {
        CoreDataView()
    }
    
    @ViewBuilder func makeSwiftData() -> some View {
        SwiftDataView()
    }
    
    @ViewBuilder func makeWeather() -> some View {
        WeatherView()
    }
    
    @ViewBuilder func makePhotoCompression() -> some View {
        PhotoCompressionView()
    }
    
    @ViewBuilder func makeStart() -> some View {
        ContentView(stateManager: AppStateManager.shared)
    }
}
