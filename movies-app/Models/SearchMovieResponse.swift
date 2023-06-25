//
//  SearchMovieResponse.swift
//  movies-app
//
//  Created by Eugene on 23.06.23.
//

import Foundation

// MARK: SearchMovieResponse
struct SearchMovieResponse: Codable {
    let search: [SearchMovie]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}
