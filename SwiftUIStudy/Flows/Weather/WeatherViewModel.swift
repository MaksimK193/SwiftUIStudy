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
    let tokenStorage: TokenStorage
    private let weatherAPIurl = "https://api.weather.yandex.ru/v2/forecast?"
    
    @Published var temperature: Int?
    var locationManager: CLLocationManager?
    var coordinate: CLLocationCoordinate2D?
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared,
         tokenStorage: TokenStorage = TokenStorageImpl()) {
        self.networkManager = networkManager
        self.tokenStorage = tokenStorage
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
        if let token = self.tokenStorage.get(tokenBy: .tokenWeather) {
            let parameters = ["lat": coordinate?.latitude,
                              "lon": coordinate?.longitude]
            let headers = ["X-Yandex-API-Key": token]
            
            //TODO: добавить передачу метода и хедера через gateway
            self.networkManager.request(url: weatherAPIurl,
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
