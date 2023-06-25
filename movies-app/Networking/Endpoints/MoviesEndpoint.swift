//
//  MoviesEndpoint.swift
//  delivery-food-app
//
//  Created by Eugene on 17.06.23.
//

import Foundation

private var API_KEY = "d245ea65"

enum MoviesEndpoint {
    case getSearchMovies(searchText: String)
    case getMovie(id: String)
}

extension MoviesEndpoint: Endpoint {
    var method: NetworkMethod {
        switch self {
        case .getSearchMovies, .getMovie:
            return .get
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .getSearchMovies, .getMovie:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .getSearchMovies, .getMovie:
            return ""
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getSearchMovies(let searchText):
            return [URLQueryItem(name: "s", value: "\(searchText)"),
                    URLQueryItem(name: "apikey", value: "\(API_KEY)")]
        case .getMovie(id: let id):
            return [URLQueryItem(name: "i", value: "\(id)"),
                    URLQueryItem(name: "apikey", value: "\(API_KEY)")]
        }
    }
    
    var headers: [String: String]? {
        let accessToken = ""
        
        switch self {
        case .getSearchMovies, .getMovie:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
}
