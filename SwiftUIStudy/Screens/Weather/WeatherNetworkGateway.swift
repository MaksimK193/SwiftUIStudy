//
//  WeatherNetworkGateway.swift
//  SwiftUIStudy
//
//  Created by USER on 24.11.2023.
//

import Foundation

enum WeatherNetworkGateway {
    case getWeather
}

extension WeatherNetworkGateway: NetworkGatewayProtocol {
    var headers: GatewayHeaders? {
        return .default
    }
    
    var method: GatewayMethod {
        return .get
    }
    
    var path: String {
        return "v2/forecast?"
    }
    
    var parameters: [String : Any]? {
        return ["lat": "55.75396", "lon": "37.620393"]
    }
}
