//
//  WeatherNetworkGateway.swift
//  SwiftUIStudy
//
//  Created by USER on 05.12.2023.
//

import Foundation
import Alamofire

final class WeatherNetworkGateway: NetworkGatewayProtocol {
    var headers: HTTPHeaders = ["X-Yandex-API-Key": "26792f4a-06cb-4c0c-aecd-b5ca965b50ab"]
    var method: HTTPMethod = .get
    var path: String = "v2/forecast?"
}
