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
    var notificationToken: NotificationToken?

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setUpUI()
        fetchFavorite()
        getNotification()
    }

    private func getNotification() {
        // Observe Results Notifications
        notificationToken = listFav?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial(let listFav):
                print("Init: \(listFav.count)")
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
            case .update(let listFav, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                print("Update: \(listFav.count)")
                tableView.beginUpdates()
                // Always apply updates in the following order: deletions, insertions, then modifications.
                // Handling insertions before deletions may result in unexpected behavior.
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }
    }

    deinit {
        notificationToken?.invalidate()
    }

    func fetchFavorite() {
        do {
            try listFav = Realm().objects(Favorite.self)
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

    func removeFavoriteVideo(json: Favorite) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                let item = realm.objects(Favorite.self).filter("videoId = %@", json.videoId as Any).first
                try realm.write {
                    if let obj = item {
                        realm.delete(obj)
                    }
                }
            } catch {
                print("KError with Realm")
            }
        }
    }

    private func setUpUI() {
        title = "VIDEO YÊU THÍCH"
        turnOffEditingMode()
    }

    @objc func turnOffEditingMode() {
        tableView.isEditing = false
        let editButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(turnOnEditingMode))
        navigationItem.rightBarButtonItem = editButton
    }

    @objc func turnOnEditingMode() {
        tableView.isEditing = true
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(turnOffEditingMode))
        navigationItem.rightBarButtonItem = doneButton
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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .none:
            return
        case .delete:
            if let list = listFav?.toArray(type: Favorite.self) {
                self.removeFavoriteVideo(json: list[indexPath.row])
            }
        case .insert:
            break
        @unknown default:
            fatalError("Error")
        }
    }
}

extension FavoriteViewController: UITableViewDelegate {

}
