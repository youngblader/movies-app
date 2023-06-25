//
//  Router.swift
//  delivery-food-app
//
//  Created by Eugene on 13.06.23.
//

import UIKit

protocol RouterProtocol {
    var di: DependencyContainer! { get set }
    
    func navigateToDetailMovieController(_ id: String, _ from: UIViewController)
    func navigateToWebViewController(_ id: String, _ from: UIViewController)
    func dismiss(_ from: UIViewController)
}

final class Router: RouterProtocol {
    weak var di: DependencyContainer!
    
    func navigateToDetailMovieController(_ id: String, _ from: UIViewController) {
        let controller = di.screenFactory.createDetailMovieController(id)

        from.navigationController?.pushViewController(controller, animated: true)
    }
    
    func navigateToWebViewController(_ id: String, _ from: UIViewController) {
        let controller = di.screenFactory.createWebViewController(id)
        
        from.present(controller, animated: true)
    }
    
    func dismiss(_ from: UIViewController) {
        from.dismiss(animated: true, completion: nil)
    }
}
