//
//  GeoTrackViewModel.swift
//  SwiftUIStudy
//
//  Created by USER on 18.12.2023.
//

import Foundation
import CoreData
import Combine
import CoreLocation

class GeoTrackViewModel: ObservableObject {
    private let coreDataManager = CoreDataManager.shared
    private let locationManager = LocationManager()
    private var coordinates = [CoordinateEntity]()
    private var cancellables = Set<AnyCancellable>()
    @Published var locationStatus: CLAuthorizationStatus

    init() {
        coreDataManager.setupDataModel(name: .Coordinates)
        locationStatus = locationManager.locationStatus ?? .denied
        setupLocationUpdates()
        setupLocationStatusUpdates()
    }
    
    func setupLocationUpdates() {
        locationManager.locationPublisher
            .sink { [weak self] location in
                self?.addCoordinate(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude, date: location.timestamp)
            }
            .store(in: &cancellables)
    }
    
    func setupLocationStatusUpdates() {
        locationManager.locationStatusPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.locationStatus, on: self)
            .store(in: &cancellables)
    }
    
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

//addCoordinate(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude, date: location.timestamp)
