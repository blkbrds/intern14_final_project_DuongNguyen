//
//  DetailViewController.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/30/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import MVVM

class DetailViewController: UIViewController, MVVM.View {

    // MARK: - Outlets
    @IBOutlet weak private var tableView: UITableView!

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
    }

    // MARK: - Custom funcs
    private func configTableView() {
        tableView.register(UINib(nibName: ReuseIdentifier.videoCell, bundle: nil), forCellReuseIdentifier: ReuseIdentifier.videoCell)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setUpUI() {
        title = "DETAIL"
        let favoriteButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-favorite"), style: .plain, target: self, action: #selector(favoriteButtonClicked))
        navigationItem.rightBarButtonItem = favoriteButton
    }

    @objc private func favoriteButtonClicked() {
        if let vid = video {
            let favorite: Favorite = Favorite()
            favorite.videoId = vid.videoId
            favorite.typeVideo = vid.typeVideo
            favorite.kind = vid.kind
            viewModel.addFavoriteVideo(json: favorite)
        }
        print("Like ne")
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
