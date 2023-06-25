//
//  DependencyContainer.swift
//  delivery-food-app
//
//  Created by Eugene on 13.06.23.
//

import UIKit

final class DependencyContainer {
    static let shared = DependencyContainer()

    //MARK: Services
    let moviesService: MoviesServiceProtocol
    
    var router: RouterProtocol
    var screenFactory: ScreenFactoryProtocol
    
    init() {
        moviesService = MoviesService()

        router = Router()
        screenFactory = ScreenFactory()
    
        screenFactory.di = self
        router.di = self
    }
}

extension DependencyContainer {
    func makeWindowWithController(scene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: scene)
        
        let rootViewController = screenFactory.createSearchMoviesController()
        window.rootViewController = rootViewController
        
        return window
    }
}
