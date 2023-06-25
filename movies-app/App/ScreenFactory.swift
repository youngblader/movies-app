//
//  ScreenFactory.swift
//  delivery-food-app
//
//  Created by Eugene on 13.06.23.
//

import UIKit

protocol ScreenFactoryProtocol {
    var di: DependencyContainer! { get set }
    
    func createSearchMoviesController() -> UINavigationController
    func createWebViewController(_ id: String) -> UINavigationController
    func createDetailMovieController(_ id: String) -> DetailMovieController
}

final class ScreenFactory: ScreenFactoryProtocol {
    weak var di: DependencyContainer!
    
    func createSearchMoviesController() -> UINavigationController {
        let viewModel = SearchMoviesViewModel(moviesService: di.moviesService, router: di.router)

        return createUINavigationController(SearchMoviesController(viewModel: viewModel))
    }
    
    func createWebViewController(_ id: String) -> UINavigationController {
        let viewModel = WebViewModel(imdbId: id, router: di.router)
        
        return createUINavigationController(WebViewController(viewModel: viewModel))
    }
    
    func createDetailMovieController(_ id: String) -> DetailMovieController {
        let viewModel = DetailMovieViewModel(moviesService: di.moviesService, router: di.router, imdbId: id)
       
        return DetailMovieController(viewModel: viewModel)
    }
}

extension ScreenFactory {
    func createUINavigationController(_ vc: UIViewController) -> UINavigationController {
        let controller = UINavigationController(rootViewController: vc)
        
        return controller
    }
}
