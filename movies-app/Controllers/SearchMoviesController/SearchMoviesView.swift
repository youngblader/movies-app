//
//  SearchMoviesView.swift
//  delivery-food-app
//
//  Created by Eugene on 12.06.23.
//

import UIKit
import SnapKit

final class SearchMoviesView: UIView {
    lazy var searchController = SearchController(searchResultsController: nil)
    lazy var searchResultsTableView = SearchResultsTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchMoviesView {
    private func setup() {
        self.backgroundColor = .white
    }
    
    private func setupViews() {
        self.addSubview(searchResultsTableView)
    }
    
    private func setupConstraints() {
        searchResultsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
