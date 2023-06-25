//
//  SearchResultsTableVIew.swift
//  movies-app
//
//  Created by Eugene on 17.06.23.
//

import UIKit

final class SearchResultsTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero

        self.separatorStyle = .none
        self.contentInset = Layout.contentInset
        
        self.register(SearchMovieCell.self, forCellReuseIdentifier: SearchMovieCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultsTableView {
    struct Layout {
        static var contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
}
