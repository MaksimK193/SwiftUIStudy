//
//  WeatherModel.swift
//  SwiftUIStudy
//
//  Created by USER on 24.11.2023.
//

import Foundation

public struct Weather: Codable {
    public var fact: Fact
}

public struct Fact: Codable {
    public var temp: Int
}
