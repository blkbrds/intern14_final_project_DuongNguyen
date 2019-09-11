//
//  DetailViewController.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/30/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import MVVM
import RealmSwift

class DetailViewController: UIViewController, MVVM.View {

    // MARK: - Outlets
    @IBOutlet weak private var tableView: UITableView!
    private var favoritesBarButtonOn: UIBarButtonItem!
    private var favoritesBarButtonOFF: UIBarButtonItem!
    private var notificationToken: NotificationToken?
    private var listFav: Results<Favorite>?

    // MARK: - Properties
    var viewModel = DetailViewModel() {
        didSet {
            setUpUI()
            updateView()
        }
    }
    var video: Video?

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setUpUI()
        fetchFavorite()
        getNotification()
    }

    // MARK: - Custom funcs
    private func getNotification() {
        // Observe Results Notifications
        notificationToken = listFav?.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial(let listFav):
                print("Init: \(listFav.count)")
                // Results are now populated and can be accessed without blocking the UI
                self?.setUpButtonFavorite()
            case .update(let listFav, _, _, _):
                // Query results have changed, so apply them to the UITableView
                print("Update: \(listFav.count)")
                self?.setUpButtonFavorite()
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

    private func configTableView() {
        tableView.register(UINib(nibName: ReuseIdentifier.videoCell, bundle: nil), forCellReuseIdentifier: ReuseIdentifier.videoCell)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setUpUI() {
        title = "DETAIL"
        favoritesBarButtonOn = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-favorite"), style: .plain, target: self, action: #selector(didTapFavoritesBarButtonOn))
        favoritesBarButtonOFF = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-fav"), style: .plain, target: self, action: #selector(didTapFavoritesBarButtonOFF))
        setUpButtonFavorite()
    }

    private func setUpButtonFavorite() {
        let favorite: Favorite = Favorite()
        if let vid = video {
            favorite.videoId = vid.videoId
            favorite.typeVideo = vid.typeVideo
            favorite.kind = vid.kind
        }
        if viewModel.isFavorite(json: favorite) {
            self.navigationItem.rightBarButtonItems = [self.favoritesBarButtonOFF]
        } else {
            self.navigationItem.rightBarButtonItems = [self.favoritesBarButtonOn]
        }
    }

    @objc private func didTapFavoritesBarButtonOFF() {
        self.navigationItem.setRightBarButtonItems([self.favoritesBarButtonOn], animated: false)
        if let vid = video {
            let favorite: Favorite = Favorite()
            favorite.videoId = vid.videoId
            favorite.typeVideo = vid.typeVideo
            favorite.kind = vid.kind
            viewModel.removeFavoriteVideo(json: favorite)
        }
    }

    @objc private func didTapFavoritesBarButtonOn() {
        self.navigationItem.setRightBarButtonItems([self.favoritesBarButtonOFF], animated: false)
        if let vid = video {
            let favorite: Favorite = Favorite()
            favorite.videoId = vid.videoId
            favorite.typeVideo = vid.typeVideo
            favorite.kind = vid.kind
            viewModel.addFavoriteVideo(json: favorite)
        }
    }

    func updateView() {
        guard isViewLoaded else { return }
        tableView.reloadData()
        viewDidUpdated()
    }
}

// MARK: - Extensions
extension DetailViewController: ViewModelDelegate {
    func viewModel(_ viewModel: ViewModel, didChangeItemsAt indexPaths: [IndexPath], changeType: ChangeType) {
        updateView()
    }
}

extension DetailViewController {

    struct ReuseIdentifier {
        static let videoCell = "VideoCell"
    }
}

extension DetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.videoCell, for: indexPath) as? VideoCell, let video = video else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.getVideo(video: video)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt()
    }
}

extension DetailViewController: UITableViewDelegate {
    // todo
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vid = video {
            print(viewModel.getVideo(video: vid))
        }
    }
}
