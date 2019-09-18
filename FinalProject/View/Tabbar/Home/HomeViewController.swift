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
  var viewModel = HomeViewModel()

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

  private func loadTrending(completed: @escaping () -> Void) {
    viewModel.loadTrending { (error) in
      if let error = error {
        self.alert(msg: error.localizedDescription, handler: nil)
      } else {
        self.tableView.beginUpdates()
        self.tableView.reloadSections(NSIndexSet(index: App.Number.sectionOfTrending) as IndexSet, with: .automatic)
        self.tableView.endUpdates()
      }
      completed()
    }
  }

  private func loadBolero(completed: @escaping () -> Void) {
    viewModel.loadBolero { (error) in
      if let error = error {
        self.alert(msg: error.localizedDescription, handler: nil)
      } else {
        self.tableView.beginUpdates()
        self.tableView.reloadSections(NSIndexSet(index: App.Number.sectionOfBolero) as IndexSet, with: .automatic)
        self.tableView.endUpdates()
      }
      completed()
    }
  }

  private func loadNhacXuan(completed: @escaping () -> Void) {
    viewModel.loadNhacXuan { (error) in
      if let error = error {
        self.alert(msg: error.localizedDescription, handler: nil)
      } else {
        self.tableView.beginUpdates()
        self.tableView.reloadSections(NSIndexSet(index: App.Number.sectionOfNhacXuan) as IndexSet, with: .automatic)
        self.tableView.endUpdates()
      }
      completed()
    }
  }

  private func loadNhacVang(completed: @escaping () -> Void) {
    viewModel.loadNhacVang { (error) in
      if let error = error {
        self.alert(msg: error.localizedDescription, handler: nil)
      } else {
        self.tableView.beginUpdates()
        self.tableView.reloadSections(NSIndexSet(index: App.Number.sectionOfNhacVang) as IndexSet, with: .automatic)
        self.tableView.endUpdates()
      }
      completed()
    }
  }

  private func loadChannel(completed: @escaping () -> Void) {
    viewModel.loadChannel { (error) in
      if let error = error {
        self.alert(msg: error.localizedDescription, handler: nil)
      } else {
        self.tableView.beginUpdates()
        self.tableView.reloadSections(NSIndexSet(index: App.Number.sectionOfChannel) as IndexSet, with: .automatic)
        self.tableView.endUpdates()
      }
      completed()
    }
  }

  private func loadData() {
    DispatchQueue.main.async {
      self.dispatchGroup.enter()
      self.loadTrending {
        self.dispatchGroup.leave()
      }

      self.dispatchGroup.enter()
      self.loadBolero {
        self.dispatchGroup.leave()
      }

      self.dispatchGroup.enter()
      self.loadNhacXuan {
        self.dispatchGroup.leave()
      }

      self.dispatchGroup.enter()
      self.loadNhacVang {
        self.dispatchGroup.leave()
      }

      self.dispatchGroup.enter()
      self.loadChannel {
        self.dispatchGroup.leave()
      }

      self.dispatchGroup.notify(queue: .main) {
        print("Load done")
      }
    }
  }
}

extension HomeViewController {
  struct ReuseIdentifier {
    static let sliderImageCell = "SliderImageCell"
    static let listSearchCell = "VideoPopularCell"
    static let channelCell = "ChannelCell"
    static let headerCell = "HeaderView"
  }
}

// MARK: - Extensions
extension HomeViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowInSection(in: section)
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let sectionType = HomeViewModel.SectionType(rawValue: section) else {
      return UIView()
    }
    switch sectionType {
    case .trending:
      return UIView()
    default:
      let headerView = Bundle.main.loadNibNamed(ReuseIdentifier.headerCell, owner: self, options: nil)?[0] as? HeaderView
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
      return App.Number.heightForSectionTrending
    default:
      return App.Number.heightForSectionDefault
    }
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 1
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return viewModel.heightForRowAt(at: indexPath)
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
      cell.viewModel = viewModel.makeSliderViewModel()
      return cell
    case .bolero:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.listSearchCell, for: indexPath) as? VideoPopularCell else {
        return UITableViewCell()
      }
      cell.viewModel = viewModel.makeBoleroViewModel()
      return cell
    case .nhacVang:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.listSearchCell, for: indexPath) as? VideoPopularCell else {
        return UITableViewCell()
      }
      cell.viewModel = viewModel.makeNhacVangViewModel()
      return cell
    case .nhacXuan:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.listSearchCell, for: indexPath) as? VideoPopularCell else {
        return UITableViewCell()
      }
      cell.viewModel = viewModel.makeNhacXuanViewModel()
      return cell
    case .channel:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.channelCell, for: indexPath) as? ChannelCell else {
        return UITableViewCell()
      }
      cell.viewModel = viewModel.getChannels(at: indexPath)
      return cell
    }
  }
}

extension HomeViewController: UITableViewDelegate {
// code
}
