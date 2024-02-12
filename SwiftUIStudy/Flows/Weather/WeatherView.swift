//
//  WeatherView.swift
//  SwiftUIStudy
//
//  Created by USER on 23.11.2023.
//

import SwiftUI
import YandexMobileMetrica

struct WeatherView: View {
    @ObservedObject private var viewModel = WeatherViewModel()
    @EnvironmentObject private var sidebarRouter: ContentCoordinator.Router
    @ObservedObject var stateManager: AppStateManager
    
    var body: some View {
        ZStack {
            let temp = viewModel.temperature == nil ? "--" : "\(viewModel.temperature!)"
            VStack {
                Text(L10n.Weather.Label.temperature(temp))//"Температура: \(temp) градусов")
                Button(L10n.Weather.Button.update) {
                    viewModel.getCurrentWeather()
                }
                .accessibilityIdentifier("weatherUpdateButton")
            }
            .onAppear {
                viewModel.checkLocationIsEnabled()
            }
            InactiveView()
                .opacity(stateManager.isActive ? 0 : 100)
        }
        .onAppear {
            YMMYandexMetrica.reportEvent("WeatherScreen opened")
        }
    }
}

#Preview {
    WeatherView(stateManager: AppStateManager.shared)
}
