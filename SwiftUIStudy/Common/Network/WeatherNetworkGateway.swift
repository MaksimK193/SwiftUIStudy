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

final class JSONNetworkGateway: NetworkGatewayProtocol {
    var headers: HTTPHeaders = []
    var method: HTTPMethod = .get
    var path: String = "https://rawgit.com/NikitaAsabin/b37bf67c8668d54a517e02fdf0e0d435/raw/2021870812a13c6dbae1f8a0e9845661396c1e8d/page2.json"
    
    init(path: String) {
        self.path = path
    }
}
