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
    private let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
    let mapView: YMKMapView = YMKMapView(frame: CGRect.zero)
    private var searchSession: YMKSearchSession?
    lazy var map: YMKMap = {
        return mapView.mapWindow.map
    }()
    @Published var lastUserLocation: CLLocation = CLLocation()
    private var cancellables = Set<AnyCancellable>()
    
    private let searchOptions: YMKSearchOptions = {
        let options = YMKSearchOptions()
        options.searchTypes = .biz
        options.resultPageSize = 32
        return options
    }()
    
    init() {        
        setupLocationUpdates()
    }
    
    func search(withText: String) {
        searchSession = searchManager.submit(
            withText: withText,
            geometry: YMKVisibleRegionUtils.toPolygon(with: map.visibleRegion),
            searchOptions: searchOptions,
            responseHandler: handleSearchSessionResponse
        )
    }
    
    func resubmitAfterMove() {
        let geometry = YMKVisibleRegionUtils.toPolygon(with: map.visibleRegion)
        searchSession?.setSearchAreaWithArea(geometry)
        searchSession?.resubmit(responseHandler: handleSearchSessionResponse)
    }
    
    private func handleSearchSessionResponse(response: YMKSearchResponse?, error: Error?) {
        if let error {
            print(error.localizedDescription)
            return
        }
        
        let geoObjects = response?.collection.children.compactMap { $0.obj }
        let coordinates = geoObjects?.first?.geometry.first?.point
        
        centerMapLocation(target: coordinates, map: mapView)
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
