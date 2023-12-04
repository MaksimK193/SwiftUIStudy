//
//  WeatherView.swift
//  SwiftUIStudy
//
//  Created by USER on 23.11.2023.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject private var viewModel = WeatherViewModel()
    @EnvironmentObject private var sidebarRouter: ContentCoordinator.Router
    @ObservedObject var stateManager: AppStateManager
    
    var body: some View {
        ZStack {
            let temp = viewModel.temperature == nil ? "--" : "\(viewModel.temperature!)"
            VStack {
                Text("Температура: \(temp) градусов")
                Button("Обновить") {
                    viewModel.getCurrentWeather()
                }
            }
            .onAppear {
                viewModel.checkLocationIsEnabled()
            }
            InactiveView()
                .opacity(stateManager.isActive ? 0 : 100)
        }
    }
}

#Preview {
    WeatherView(stateManager: AppStateManager.shared)
}
