//
//  YandexMapLocationManager.swift
//  SwiftUIStudy
//
//  Created by USER on 24.01.2024.
//

import Foundation
import Combine
import CoreLocation
import YandexMapsMobile

class YandexMapLocationManager: ObservableObject {
    private let locationManager = LocationManager()
    let mapView: YMKMapView = YMKMapView(frame: CGRect.zero)
    private var cancellables = Set<AnyCancellable>()
    @Published var lastUserLocation: CLLocation = CLLocation()
    lazy var map: YMKMap = {
        return mapView.mapWindow.map
    }()
    
    init() {        setupLocationUpdates()
    }
    
    func setupLocationUpdates() {
        locationManager.locationPublisher
            .assign(to: \.lastUserLocation, on: self)
            .store(in: &cancellables)
    }
    
    func setupFirstLocation() {
        lastUserLocation = locationManager.locationManager.location ?? CLLocation()
        self.currentUserLocation()
    }
    
    func currentUserLocation(){
        centerMapLocation(target: YMKPoint(latitude: lastUserLocation.coordinate.latitude, longitude: lastUserLocation.coordinate.longitude), map: mapView )
    }
    
    func centerMapLocation(target location: YMKPoint?, map: YMKMapView) {
        
        guard let location = location else { print("Failed to get user location"); return }
        
        map.mapWindow.map.move(
            with: YMKCameraPosition(target: location, zoom: 18, azimuth: 0, tilt: 0),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.5)
        )
    }
}
