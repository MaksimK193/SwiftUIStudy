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
    func checkLocationIsEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager = CLLocationManager()
                self.locationManager?.delegate = self
                self.checkLocationAuth()
            }
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
        checkLocationIsEnabled()
        
        if let url = ProcessInfo.processInfo.environment["YNDX_WEATHER_API_URL"],
           let token = ProcessInfo.processInfo.environment["YNDX_WEATHER_API_TOKEN"] {
            let parameters = ["lat": coordinate?.latitude,
                              "lon": coordinate?.longitude]
            let headers = ["X-Yandex-API-Key": token]
            
            self.networkManager.request(url: url,
                                        method: .get,
                                        parameters: parameters,
                                        headers: headers,
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
}
