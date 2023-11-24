//
//  WeatherView.swift
//  SwiftUIStudy
//
//  Created by USER on 23.11.2023.
//

import SwiftUI

struct WeatherView: View {
    @State private var viewModel = WeatherViewModel()
    private var tokenStorage = TokenStorage()
    
    var body: some View {
        Text("Температура: \(viewModel.temperature ?? 999) градусов")
        Button {
            tokenStorage.set(token: "26792f4a-06cb-4c0c-aecd-b5ca965b50ab", key: .weather)
            viewModel.getCurrentWeather()
        } label: {
            Text("Обновить")
        }

    }
}

#Preview {
    WeatherView()
}
