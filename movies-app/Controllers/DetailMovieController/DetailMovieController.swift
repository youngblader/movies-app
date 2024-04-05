//
//  DetailMovieController.swift
//  movies-app
//
//  Created by Eugene on 12.06.23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class DetailMovieController: UIViewController {
    private var viewModel: DetailMovieViewModel

    // LoadView
    private var detailMovieView: DetailMovieView {
        return self.view as! DetailMovieView
    }
    
    override func loadView() {
        self.view = DetailMovieView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        viewModel.fetchMovie()
        
        detailMovieView.onRedirectButtonTapped = { [weak self] in
            self?.redirectButtonTapped()
        }
        
        if let movie = viewModel.selectedMovie {
            detailMovieView.update(movie)
        }
    }
    
    init(viewModel: DetailMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func redirectButtonTapped() {
        viewModel.router.navigateToWebViewController(viewModel.imdbId, self)
    }
}

extension DetailMovieController {
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}
