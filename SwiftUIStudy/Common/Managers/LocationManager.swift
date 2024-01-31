//
//  LocationManager.swift
//  SwiftUIStudy
//
//  Created by USER on 24.01.2024.
//

import Foundation
import Combine
import CoreLocation
import RxSwift
import RxRelay

class LocationManager: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    let locationRelay = BehaviorRelay(value: CLLocation())
    let locationStatusRelay = BehaviorRelay<CLAuthorizationStatus>(value: .notDetermined)
    var locationStatus: CLAuthorizationStatus?
    var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
    }
    
    private func checkLocationAuth() {
        guard let locationStatus = locationStatus else { return }
        switch locationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Ограничен")
        case .denied:
            print("Отключены")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        locationStatusRelay.accept(status)
        checkLocationAuth()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationRelay.accept(location)
        print("locManager: \(location)")
    }
}
