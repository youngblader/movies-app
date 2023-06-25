//
//  SearchMovie.swift
//  movies-app
//
//  Created by Eugene on 23.06.23.
//

import Foundation

// MARK: SearchMovie
struct SearchMovie: Codable {
    let title, year, imdbID: String
    let type: TypeMovie
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
