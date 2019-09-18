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
  private let dispatchGroup = DispatchGroup()
  var homeViewModel = HomeViewModel()

  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
    setUpUI()
    configTableView()
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
    title = App.String.homeTitle
  }
  
  func loadTrending(completed: @escaping () -> ()) {
    homeViewModel.getTrending { (error) in
      if let error = error {
        // show error
      } else {
        //update UI
      }
      completed()
    }
  }

  private func loadData() {
    homeViewModel.getData()
    
    dispatchGroup.enter()
    loadTrending {
      self.dispatchGroup.leave()
    }

    dispatchGroup.enter()
    homeViewModel.getTrending(keySearch: App.String.trendingKeySearch, maxResults: 5) { [weak self] result in
      guard let this = self else { return }
      switch result {
      case .success:
        break
      case .failure(let error):
        this.alert(title: "List trending load failed", msg: error.localizedDescription, handler: nil)
      }
      this.dispatchGroup.leave()
    }

    dispatchGroup.enter()
    homeViewModel.getChannel(keySearch: App.String.channelKeySearch, maxResults: 10) { [weak self] result in
      guard let this = self else { return }
      switch result {
      case .success:
        break
      case .failure(let error):
        this.alert(title: "List channel load failed", msg: error.localizedDescription, handler: nil)
      }
      this.dispatchGroup.leave()
    }

    dispatchGroup.notify(queue: .main, execute: { [weak self] in
      guard let this = self else { return }
      this.tableView.reloadData()})
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
    switch sectionType {
    case .trending:
      return UIView()
    default:
      let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?[0] as? HeaderView
      headerView?.updateUI(title: sectionType.title)
      return headerView
    }
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard let sectionType = HomeViewModel.SectionType(rawValue: section) else {
      return 0
    }
    switch sectionType {
    case .trending:
      return 1
    default:
      return 30
    }
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 1
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
