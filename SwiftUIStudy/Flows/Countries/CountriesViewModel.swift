//
//  CountriesViewModel.swift
//  SwiftUIStudy
//
//  Created by USER on 17.01.2024.
//

import Foundation
import CoreData
import UIKit
import RxSwift
import RxAlamofire

class CountriesViewModel: ObservableObject {
    private let networkManager = NetworkManager.shared
    private let imageLoader = ImageLoader()
    private let coreDataManager = CoreDataManager.shared
    private let disposeBag = DisposeBag()
    var next = ""
    
    @Published var countriesCoreData: [CountryEntity] = []
    
    init() {
        coreDataManager.setupDataModel(name: .Countries)
    }
    
    func fetch(next: String = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json") {
        let gateway = JSONNetworkGateway(path: next)
        RxAlamofire
            .requestJSON(gateway.method,
                       gateway.path,
                       headers: gateway.headers)
            .debug()
            .subscribe(onNext: { [weak self] response, json in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: json)
                    let data = try JSONDecoder().decode(CountryResponse.self, from: jsonData)
                    self?.next = data.next
                    data.countries.compactMap { country in
                        let contains = self?.countriesCoreData.contains { $0.name == country.name }
                        if contains == false  {
                            self?.addCountry(country: country)
                        }
                        self?.getCountries()
                    }
                } catch {
                    print("Error serialization")
                }
            })
            .disposed(by: disposeBag)
    }
}

extension CountriesViewModel {
    func addCountry(country: CountryModel) {
        let newCountry = CountryEntity(context: coreDataManager.context)
        
        newCountry.capital = country.capital
        newCountry.continent = country.continent
        newCountry.description_big = country.description
        newCountry.description_small = country.description_small
        newCountry.flagImage = country.country_info.flag
        newCountry.infoImages = country.country_info.images
        newCountry.population = Int64(country.population)
        newCountry.name = country.name
        
        coreDataManager.save()
    }
    
    func getCountries() {
        countriesCoreData.removeAll()
        let request = NSFetchRequest<CountryEntity>(entityName: "CountryEntity")
        do {
            countriesCoreData = try coreDataManager.context.fetch(request)
        } catch let error {
            print("Error fetching entity: \(error.localizedDescription)")
        }
    }
}
