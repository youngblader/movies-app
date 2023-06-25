//
//  SearchController.swift
//  delivery-food-app
//
//  Created by Eugene on 4.06.23.
//

import UIKit

final class SearchController: UISearchController {
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: nil)
    
        self.searchBar.placeholder = "Search"
        self.obscuresBackgroundDuringPresentation = false
        
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
}
