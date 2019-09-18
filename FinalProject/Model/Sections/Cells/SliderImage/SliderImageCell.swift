//
//  SliderImageCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

final class SliderImageCell: UITableViewCell {

  // MARK: - Outlets
  @IBOutlet weak private var collectionView: UICollectionView!
  @IBOutlet weak private var pageView: UIPageControl!

  // MARK: - Properties
  private var timer = Timer()
  private var counter = 0

  var viewModel: SliderCellViewModel? {
    didSet {
      updateView()
      configPageView()
    }
  }

  // MARK: - Life Cycles
  override func awakeFromNib() {
    super.awakeFromNib()
    configCollectionView()
  }

  // MARK: - Custom funcs
  private func configCollectionView() {
    let cellNib = UINib(nibName: ReuseIndentifier.sliderImageCollectionViewCell, bundle: Bundle.main)
    collectionView.register(cellNib, forCellWithReuseIdentifier: ReuseIndentifier.sliderImageCollectionViewCell)
    collectionView.dataSource = self
    collectionView.delegate = self
  }

  private func updateView() {
    collectionView.reloadData()
  }

  private func configPageView() {
    guard let viewModel = viewModel else { return }
    pageView.numberOfPages = viewModel.numberOfImages()
    pageView.currentPage = 0
    if pageView.numberOfPages != 0 {
      self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
    }
  }

  @objc func changeImage() {
    guard let viewModel = viewModel else { return }
    if counter < viewModel.numberOfImages() {
      let index = IndexPath(item: counter, section: 0)
      self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
      pageView.currentPage = counter
      counter += 1
    } else {
      counter = 0
      let index = IndexPath(item: counter, section: 0)
      self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
      pageView.currentPage = counter
      counter = 1
    }
  }
}

// MARK: - Extensions
extension SliderImageCell {
  struct ReuseIndentifier {
    static let sliderImageCollectionViewCell = "SliderImageCollectionViewCell"
  }
}

extension SliderImageCell: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let viewModel = viewModel else { return 0 }
    return viewModel.numberOfImages()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIndentifier.sliderImageCollectionViewCell, for: indexPath) as? SliderImageCollectionViewCell,
      let viewModel = viewModel else {
      return UICollectionViewCell()
    }
    cell.viewModel = viewModel.getSliderImages(at: indexPath)
    return cell
  }
}

extension SliderImageCell: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width, height: 200)
  }
}
