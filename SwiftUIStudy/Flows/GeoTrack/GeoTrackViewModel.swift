//
//  GeoTrackViewModel.swift
//  SwiftUIStudy
//
//  Created by USER on 18.12.2023.
//

import Foundation
import CoreLocation
import CoreData

class GeoTrackViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let coreDataManager = CoreDataManager.shared
    private var coordinates = [CoordinateEntity]()
    private let locationManager = CLLocationManager()
    var locationStatus: CLAuthorizationStatus?
    var lastLocation: CLLocation?

    override init() {
        super.init()
        coreDataManager.setupDataModel(name: .Coordinates)
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
        checkLocationAuth()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print(location)
        addCoordinate(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude, date: location.timestamp)
    }
}

extension GeoTrackViewModel {
    func addCoordinate(longitude: Double, latitude: Double, date: Date) {
        let newCoordinate = CoordinateEntity(context: coreDataManager.context)
        newCoordinate.latitude = latitude
        newCoordinate.longitude = longitude
        newCoordinate.date = date
        coreDataManager.save()
    }
    
    func getCoordinates() {
        let request = NSFetchRequest<CoordinateEntity>(entityName: "CoordinateEntity")
        do {
            coordinates = try coreDataManager.context.fetch(request)
        } catch let error {
            print("Error fetching entity: \(error.localizedDescription)")
        }
    }
}
