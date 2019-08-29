//
//  SearchViewController.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search bar"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
    }
}
