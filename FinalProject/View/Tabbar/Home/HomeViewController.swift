//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak private var tableView: UITableView!

    // MARK: - Properties
    var homeViewModel = HomeViewModel() {
        didSet {
            setUpUI()
        }
    }

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setUpUI()
        loadData()
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
        homeViewModel.getData()
    }

    // MARK: - Actions
}

extension HomeViewController {
    struct ReuseIdentifier {
        static let sliderImageCell = "SliderImageCell"
        static let listSearchCell = "VideoPopularCell"
        static let channelCell = "ChannelCell"
    }
}

// MARK: - Extensions
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
             cell.viewModel = homeViewModel.makeVideoViewModel()
            return cell
        case .nhacVang:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.listSearchCell, for: indexPath) as? VideoPopularCell else {
                return UITableViewCell()
            }
            cell.viewModel = homeViewModel.makeVideoViewModel()
            return cell
        case .nhacXuan:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.listSearchCell, for: indexPath) as? VideoPopularCell else {
                return UITableViewCell()
            }
            cell.viewModel = homeViewModel.makeVideoViewModel()
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
// code
}
