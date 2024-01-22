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
    
    @Published var countries: [CountryModel] = []
    @Published var countriesCoreData: [CountryEntity] = []
    
    init() {
        coreDataManager.setupDataModel(name: .Countries)
    }
    
    func fetch(next: String = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json") {
        getCountries()
        networkManager.request(gateway: JSONNetworkGateway(path: next), parameters: [:], resultType: CountryResponse.self) { result in
            switch result {
            case .success(let data):
                self.next = data?.next ?? ""
                data?.countries.compactMap { country in
                    if !self.countries.contains(country) {
                        self.countries.append(country)
                        self.addCountry(country: country)
                    }
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
        
        newCountry.id = country.id
        newCountry.capital = country.capital
        newCountry.continent = country.continent
        newCountry.description_big = country.description
        newCountry.description_small = country.description_small
        
        imageLoader.load(fromURLString: country.country_info.flag)
        if let image = imageLoader.image {
            newCountry.flagImageData = image.pngData()
        } else {
            newCountry.flagImageData = UIImage(systemName: "photo")?.pngData()
        }
        
        var infoImages: [Data] = []
        for _ in country.country_info.images {
            imageLoader.load(fromURLString: country.country_info.flag)
            if let image = imageLoader.image {
                infoImages.append(image.pngData()!)
            } else {
                infoImages.append((UIImage(systemName: "photo")?.pngData())!)
            }
        }
        newCountry.infoImages = infoImages
        
        newCountry.name = country.name
        
        coreDataManager.save()
    }
    
    func getCountries() {
        let request = NSFetchRequest<CountryEntity>(entityName: "CountryEntity")
        do {
            countriesCoreData = try coreDataManager.context.fetch(request)
            if !countriesCoreData.isEmpty {
                for country in countriesCoreData {
                    let countryModel = CountryModel(name: country.name!, continent: country.continent!, capital: country.capital!, population: Int(country.population), description_small: country.description_small!, description: country.description_big!, image: "", country_info: CountryInfo(images: [], flag: ""))
                    if !self.countries.contains(countryModel) {
                        countries.append(countryModel)
                    }
                }
            }
        } catch let error {
            print("Error fetching entity: \(error.localizedDescription)")
        }
    }
}
