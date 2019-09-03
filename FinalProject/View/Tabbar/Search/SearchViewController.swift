//
//  SearchViewController.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)

    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setUpUI()
    }

    // MARK: - Custom funcs
    private func configTableView() {
        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setUpUI() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search bar"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: - Extensions
extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else {
            return UITableViewCell()
        }
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {

}

extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
// to do
    }
}
