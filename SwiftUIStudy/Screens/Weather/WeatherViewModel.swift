//
//  WeatherViewModel.swift
//  SwiftUIStudy
//
//  Created by USER on 24.11.2023.
//

import Foundation

class WeatherViewModel: ObservableObject {
    let networkManager: NetworkManagerProtocol
    @Published var temperature: Int?
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func getCurrentWeather() -> Int? {
        let gateway = WeatherNetworkGateway.getWeather
        
        self.networkManager.request(gateway,
                                    resultType: Weather.self,
                                    result: { result in
            switch result {
            case .success(let data):
                self.temperature = data?.fact.temp
            case .failure(let error):
                print(error)
            }
        })
        return temperature
    }
}
