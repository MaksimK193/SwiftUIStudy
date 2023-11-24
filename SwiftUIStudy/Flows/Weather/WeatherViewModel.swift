//
//  WeatherViewModel.swift
//  SwiftUIStudy
//
//  Created by USER on 24.11.2023.
//

import Foundation
import CoreLocation

class WeatherViewModel: NSObject, ObservableObject {
    let networkManager: NetworkManagerProtocol
    @Published var temperature: Int?
    var locationManager: CLLocationManager?
    var coordinate: CLLocationCoordinate2D?
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
}

extension WeatherViewModel: CLLocationManagerDelegate {
    func checkLocationIsEnable() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        } else {
            print("alert")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
    
    private func checkLocationAuth() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Ограничен")
        case .denied:
            print("Отключены")
        case .authorizedAlways, .authorizedWhenInUse:
            coordinate = locationManager.location?.coordinate
        @unknown default:
            break
        }
    }
}

extension WeatherViewModel {
    func getCurrentWeather() {
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
    }
}
