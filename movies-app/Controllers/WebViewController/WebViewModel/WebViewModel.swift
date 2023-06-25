//
//  WebViewModel.swift
//  movies-app
//
//  Created by Eugene on 22.06.23.
//

import Foundation

protocol WebViewModelProtocol {
    var imdbId: String { get set }
}

final class WebViewModel: WebViewModelProtocol {
    var imdbId: String
    var router: RouterProtocol
    
    init(imdbId: String, router: RouterProtocol) {
        self.imdbId = imdbId
        self.router = router
    }
}
