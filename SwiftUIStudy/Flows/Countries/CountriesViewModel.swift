//
//  CountriesViewModel.swift
//  SwiftUIStudy
//
//  Created by USER on 17.01.2024.
//

import Foundation
import CoreData
import UIKit

class CountriesViewModel: ObservableObject {
    private let networkManager = NetworkManager.shared
    private let imageLoader = ImageLoader()
    private let coreDataManager = CoreDataManager.shared
    var next = ""
    
    @Published var countriesCoreData: [CountryEntity] = []
    
    init() {
        coreDataManager.setupDataModel(name: .Countries)
    }
    
    func fetch(next: String = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json") {
        networkManager.request(gateway: JSONNetworkGateway(path: next), parameters: [:], resultType: CountryResponse.self) { result in
            switch result {
            case .success(let data):
                self.next = data?.next ?? ""
                data?.countries.compactMap { country in
                    DispatchQueue.main.async {
                        let contains = self.countriesCoreData.contains { $0.name == country.name }
                        if !contains  {
                            self.addCountry(country: country)
                        }
                    }
                    self.getCountries()
                }
            case .failure(let failure):
                print(failure)
            }
        }
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
