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
    let drivingRouter: YMKDrivingRouter = YMKDirections.sharedInstance().createDrivingRouter()
    let mapView: YMKMapView = YMKMapView(frame: CGRect.zero)
    
    private var searchSession: YMKSearchSession?
    private var drivingSession: YMKDrivingSession?
    @Published var lastUserLocation: CLLocation = CLLocation()
    private var cancellables = Set<AnyCancellable>()
    
    lazy var map: YMKMap = {
        return mapView.mapWindow.map
    }()
    var routesCollection: YMKMapObjectCollection!
    
    private let searchOptions: YMKSearchOptions = {
        let options = YMKSearchOptions()
        options.searchTypes = .geo
        options.resultPageSize = 32
        return options
    }()
    
    let drivingOptions: YMKDrivingDrivingOptions = {
        let options = YMKDrivingDrivingOptions()
        options.routesCount = 3
        return options
    }()
    
    init() {        
        setupLocationUpdates()
        routesCollection = map.mapObjects.add()
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
    
    func currentUserLocation() {
        centerMapLocation(target: YMKPoint(latitude: lastUserLocation.coordinate.latitude, longitude: lastUserLocation.coordinate.longitude), map: mapView )
    }
    
    func centerMapLocation(target location: YMKPoint?, map: YMKMapView) {
        
        guard let location = location else { return }
        
        map.mapWindow.map.move(
            with: YMKCameraPosition(target: location, zoom: 18, azimuth: 0, tilt: 0),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.5)
        )
    }
}

extension YandexMapLocationManager {
    func createRoute(point: YMKPoint) {
        let points = [
            YMKRequestPoint(point: YMKPoint(latitude: lastUserLocation.coordinate.latitude, longitude: lastUserLocation.coordinate.longitude), type: .waypoint, pointContext: nil, drivingArrivalPointId: nil),
            YMKRequestPoint(point: point, type: .waypoint, pointContext: nil, drivingArrivalPointId: nil)
        ]
        
        drivingSession = drivingRouter.requestRoutes(
            with: points,
            drivingOptions: drivingOptions,
            vehicleOptions: YMKDrivingVehicleOptions(),
            routeHandler: drivingRouteHandler)
    }
    
    func drivingRouteHandler(drivingRoutes: [YMKDrivingRoute]?, error: Error?) {
        if let error {
            print(error.localizedDescription)
            return
        }
        
        guard let polyline = drivingRoutes?.first?.geometry else { return }
        
        drawRoute(polyline: polyline)
    }
    
    func drawRoute(polyline: YMKPolyline) {
        routesCollection.clear()
        let polylineMapObject = routesCollection.addPolyline(with: polyline)
        polylineMapObject.strokeWidth = 5.0
        polylineMapObject.setStrokeColorWith(.gray)
        polylineMapObject.outlineWidth = 1.0
        polylineMapObject.outlineColor = .black
    }
}

extension YandexMapLocationManager {
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
        guard let coordinates = geoObjects?.first?.geometry.first?.point else { return }
        
        centerMapLocation(target: coordinates, map: mapView)
        createRoute(point: coordinates)
    }
}
