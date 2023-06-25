//
//  DetailMovieViewModel.swift
//  movies-app
//
//  Created by Eugene on 16.06.23.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailMovieViewModelProtocol {
    var imdbId: String { get set }
    var selectedMovie: Observable<Movie>? { get set }
    
    func fetchMovie()
}

final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    private let moviesService: MoviesServiceProtocol
    var router: RouterProtocol
    
    var imdbId: String
    var selectedMovie: Observable<Movie>?
    
    init(moviesService: MoviesServiceProtocol, router: RouterProtocol, imdbId: String) {
        self.moviesService = moviesService
        self.router = router
        self.imdbId = imdbId
    }
    
    func fetchMovie() {
        let observableMovie = Observable<Movie>.create { observer in
            let task = Task {
                do {
                    let movie = try await self.moviesService.fetchMovie(self.imdbId)
                    
                    observer.onNext(movie)
                } catch {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create { task.cancel() }
        }
        
        self.selectedMovie = observableMovie
    }
}
