//
//  MoviesService.swift
//  movies-app
//
//  Created by Eugene on 17.06.23.
//

import Foundation
import RxSwift
import RxCocoa

protocol MoviesServiceProtocol {
    func fetchSearchMovie(_ text: String) async throws -> [SearchMovie]
    func fetchMovie(_ id: String) async throws -> Movie
}

final class MoviesService: MoviesServiceProtocol, API {
    func fetchSearchMovie(_ text: String) async throws -> [SearchMovie] {
        return try await request(endpoint: MoviesEndpoint.getSearchMovies(searchText: text), responseModel: SearchMovieResponse.self).search
    }
    
    func fetchMovie(_ id: String) async throws -> Movie {
        return try await request(endpoint: MoviesEndpoint.getMovie(id: id), responseModel: Movie.self)
    }
}
