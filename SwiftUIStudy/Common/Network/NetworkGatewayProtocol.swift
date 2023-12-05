//
//  NetworkGatewayProtocol.swift
//  SwiftUIStudy
//
//  Created by USER on 05.12.2023.
//

import Foundation
import Alamofire

protocol NetworkGatewayProtocol {
    var headers: HTTPHeaders { get }
    var method: HTTPMethod { get }
    var path: String { get }
}
