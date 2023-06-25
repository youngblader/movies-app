//
//  Endpoint.swift
//  delivery-food-app
//
//  Created by Eugene on 17.06.23.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: NetworkMethod { get }
    var parameters: [URLQueryItem] { get }
    var headers: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "www.omdbapi.com"
    }
    
//    var path: String {
//        return "/api/rest"
//    }
}
