//
//  WeatherView.swift
//  SwiftUIStudy
//
//  Created by USER on 23.11.2023.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        let temp = viewModel.temperature == nil ? "--" : "\(viewModel.temperature!)"
        VStack {
            Text("Температура: \(temp) градусов")
            Button {
                viewModel.getCurrentWeather()
            } label: {
                Text("Обновить")
            }
        }
        .onAppear {
            viewModel.checkLocationIsEnabled()
        }
    }
}

#Preview {
    WeatherView()
}
