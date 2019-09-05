//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import MVVM

final class HomeViewController: UIViewController, MVVM.View {

    // MARK: - Outlets
    @IBOutlet weak private var tableView: UITableView!

    // MARK: - Properties
    var homeViewModel = HomeViewModel() {
        didSet {
            setUpUI()
            updateView()
        }
    }

    struct Search {

        enum KeySearch {
            case bolero
            case nhacXuan
            case nhacVang
            case channel
            case trending
            var key: String {
                switch self {
                case .bolero:
                    return "bolero"
                case .nhacXuan:
                    return "nhacxuan"
                case .nhacVang:
                    return "nhacvang"
                case .channel:
                    return "karaoke"
                case .trending:
                    return ""
                }
            }
        }
    }

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.delegate = self
        configTableView()
        setUpUI()
        loadData()
    }

    func updateView() {
        guard isViewLoaded else { return }
        tableView.reloadData()
        viewDidUpdated()
    }

    // MARK: - Custom funcs
    private func configTableView() {
        tableView.register(UINib(nibName: ReuseIdentifier.sliderImageCell, bundle: nil), forCellReuseIdentifier: ReuseIdentifier.sliderImageCell)
        tableView.register(UINib(nibName: ReuseIdentifier.listSearchCell, bundle: nil), forCellReuseIdentifier: ReuseIdentifier.listSearchCell)
        tableView.register(UINib(nibName: ReuseIdentifier.channelCell, bundle: nil), forCellReuseIdentifier: ReuseIdentifier.channelCell)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setUpUI() {
        title = "HOME"
    }

    private func loadData() {
        homeViewModel.getSnippets(keySearch: Search.KeySearch.trending, maxResults: 5) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let error):
                this.alert(title: "", msg: error.localizedDescription, handler: nil)
            }
        }
        homeViewModel.getSnippets(keySearch: Search.KeySearch.channel, maxResults: 10) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let error):
                this.alert(title: "", msg: error.localizedDescription, handler: nil)
            }
        }
        homeViewModel.getSnippets(keySearch: Search.KeySearch.nhacVang, maxResults: 10) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let error):
                this.alert(title: "", msg: error.localizedDescription, handler: nil)
            }
        }
        homeViewModel.getSnippets(keySearch: Search.KeySearch.nhacXuan, maxResults: 10) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let error):
                this.alert(title: "", msg: error.localizedDescription, handler: nil)
            }
        }
        homeViewModel.getSnippets(keySearch: Search.KeySearch.bolero, maxResults: 10) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let error):
                this.alert(title: "", msg: error.localizedDescription, handler: nil)
            }
        }
    }

    // MARK: - Actions
}

// MARK: - Extensions
extension HomeViewController: ViewModelDelegate {
    func viewModel(_ viewModel: ViewModel, didChangeItemsAt indexPaths: [IndexPath], changeType: ChangeType) {
        updateView()
    }
}

extension HomeViewController {
    struct ReuseIdentifier {
        static let sliderImageCell = "SliderImageCell"
        static let listSearchCell = "VideoPopularCell"
        static let channelCell = "ChannelCell"
    }
}

extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return homeViewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.numberOfRowInSection(in: section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionType = HomeViewModel.SectionType(rawValue: section) else {
            return UIView()
        }
        let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?[0] as? HeaderView
        headerView?.updateUI(title: sectionType.title)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionType = HomeViewModel.SectionType(rawValue: section) else {
            return 0
        }
        switch sectionType {
        case .trending:
            return 0
        default:
            return 30
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return homeViewModel.heightForRowAt(at: indexPath)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = HomeViewModel.SectionType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch sectionType {
        case .trending:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.sliderImageCell, for: indexPath) as? SliderImageCell else {
                return UITableViewCell()
            }
            cell.viewModel = homeViewModel.makeSliderViewModel()
            return cell
        case .bolero:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.listSearchCell, for: indexPath) as? VideoPopularCell else {
                return UITableViewCell()
            }
             cell.viewModel = homeViewModel.makeVideoViewModel(for: indexPath)
            return cell
        case .nhacVang:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.listSearchCell, for: indexPath) as? VideoPopularCell else {
                return UITableViewCell()
            }
            cell.viewModel = homeViewModel.makeVideoViewModel(for: indexPath)
            return cell
        case .nhacXuan:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.listSearchCell, for: indexPath) as? VideoPopularCell else {
                return UITableViewCell()
            }
            cell.viewModel = homeViewModel.makeVideoViewModel(for: indexPath)
            return cell
        case .channel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.channelCell, for: indexPath) as? ChannelCell else {
                return UITableViewCell()
            }
            cell.viewModel = homeViewModel.getChannels(at: indexPath)
            return cell
        }
    }
}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
