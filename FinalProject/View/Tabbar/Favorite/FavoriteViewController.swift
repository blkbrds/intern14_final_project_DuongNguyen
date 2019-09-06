//
//  FavoriteViewController.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import RealmSwift

 final class FavoriteViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak private var tableView: UITableView!
    private var listFav: Results<Favorite>?
    private var listData: Results<Snippet>?

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setUpUI()
        fetchFavorite()
    }

    func fetchFavorite() {
        do {
            try listFav = Realm().objects(Favorite.self)
            //try listData = Re
        } catch {
            listFav = nil
        }
    }

    // MARK: - Custom funcs
    private func configTableView() {
        tableView.register(UINib(nibName: ReuseIdentifier.searchCell, bundle: nil), forCellReuseIdentifier: ReuseIdentifier.searchCell)
        tableView.allowsMultipleSelection = true
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setUpUI() {
        title = "VIDEO YÊU THÍCH"
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
        navigationItem.rightBarButtonItem = deleteButton
    }
}

// MARK: - Extensions

extension FavoriteViewController {
    struct ReuseIdentifier {
        static let searchCell = "SearchCell"
    }
}

extension FavoriteViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = listFav else {
            return 0
        }
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.searchCell, for: indexPath) as? SearchCell, let list = listFav else {
            return UITableViewCell()
        }
        cell.titleLabel.text = list[indexPath.row].videoId
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {

}
