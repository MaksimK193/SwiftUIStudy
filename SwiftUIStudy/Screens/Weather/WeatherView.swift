//
//  WeatherView.swift
//  SwiftUIStudy
//
//  Created by USER on 23.11.2023.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        let temp = viewModel.temperature == nil ? "--" : "\(viewModel.temperature!)"
        Text("Температура: \(temp) градусов")
        Button {
            viewModel.getCurrentWeather()
        } label: {
            Text("Обновить")
        }

    }
}

#Preview {
    WeatherView()
}
