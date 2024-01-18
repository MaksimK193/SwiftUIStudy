//
//  CountryModel.swift
//  SwiftUIStudy
//
//  Created by USER on 17.01.2024.
//

import Foundation

struct CountryModel: Codable, Identifiable, Equatable {
    var id: String {
        self.name
    }
    let name: String
    let continent: String
    let capital: String
    let population: Int
    let description_small: String
    let description: String
    let image: URL
    let country_info: CountryInfo
    
    static func == (lhs: CountryModel, rhs: CountryModel) -> Bool {
        lhs.id == rhs.id
    }
}

struct CountryInfo: Codable {
    let images: [URL]
    let flag: URL
}
