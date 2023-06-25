//
//  SearchMoviesViewModel.swift
//  movies-app
//
//  Created by Eugene on 12.06.23.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchMoviesViewModelProtocol {
    func fetchSearchMovies(_ searchText: String) -> Observable<[SearchMovie]>
}

final class SearchMoviesViewModel: SearchMoviesViewModelProtocol {
    private var moviesService: MoviesServiceProtocol
    var router: RouterProtocol
    
    init(moviesService: MoviesServiceProtocol, router: RouterProtocol) {
        self.moviesService = moviesService
        self.router = router
    }
    
    func fetchSearchMovies(_ searchText: String) -> Observable<[SearchMovie]> {
        return Observable<[SearchMovie]>.create { observer in
            let task = Task {
                do {
                    let movies = try await self.moviesService.fetchSearchMovie(searchText)
                    observer.onNext(movies)
                } catch {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
