//
//  SearchMoviesController.swift
//  movies-app
//
//  Created by Eugene on 12.06.23.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchMoviesController: UIViewController {
    private let viewModel: SearchMoviesViewModel
    
    private let bag = DisposeBag()
    
    // LoadView
    private var searchMoviesView: SearchMoviesView {
        return self.view as! SearchMoviesView
    }
    
    override func loadView() {
        self.view = SearchMoviesView(frame: UIScreen.main.bounds)
    }
    
    init(viewModel: SearchMoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

        searchResultsBinding()
        selectMovieBinding()
    }
    
    private func searchControllerBinding() -> Observable<[SearchMovie]> {
        return searchMoviesView.searchController.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .flatMapLatest { query -> Observable<[SearchMovie]> in
                if query.isEmpty {
                    return .just([])
                }
                return self.viewModel.fetchSearchMovies(query)
                    .catchAndReturn([])
            }
            .observe(on: MainScheduler.instance)
    }
    
    private func searchResultsBinding() {
        searchControllerBinding()
            .bind(to: searchMoviesView.searchResultsTableView.rx.items(cellIdentifier: SearchMovieCell.reuseId, cellType: SearchMovieCell.self)) { index, model, cell in
                cell.selectionStyle = .none
                
                cell.update(model)
            }.disposed(by: bag)
    }
    
    private func selectMovieBinding() {
        searchMoviesView.searchResultsTableView.rx.modelSelected(SearchMovie.self)
            .subscribe(onNext: { (model) in
                self.presentDetailMovieController(model)
            }).disposed(by: bag)
    }
    
    private func presentDetailMovieController(_ movie: SearchMovie) {
        viewModel.router.navigateToDetailMovieController(movie.imdbID, self)
    }
}

extension SearchMoviesController {
    private func setup() {
        self.title = "Movies Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchMoviesView.searchController
    }
}
