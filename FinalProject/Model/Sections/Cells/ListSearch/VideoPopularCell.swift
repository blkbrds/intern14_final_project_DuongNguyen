//
//  VideoPopularCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import MVVM

final class VideoPopularCell: UITableViewCell, MVVM.View {

  // MARK: - Outlets
  @IBOutlet weak private var collectionView: UICollectionView!

  // MARK: - Properties
  var viewModel: VideoPopularCellViewModel? {
    didSet {
      updateUI()
    }
  }
  private let numberOfImage: CGFloat = 4

  // MARK: - Life Cycles
  override func awakeFromNib() {
    super.awakeFromNib()
    configCollectionView()
  }

  // MARK: - Custom funcs
  private func configCollectionView() {
    let cellNib = UINib(nibName: ReuseIndentifier.imageCollectionCell, bundle: Bundle.main)
    collectionView.register(cellNib, forCellWithReuseIdentifier: ReuseIndentifier.imageCollectionCell)
    collectionView.dataSource = self
    collectionView.delegate = self
  }

  private func updateUI() {
    collectionView.reloadData()
  }
}

// MARK: - Extensions
extension VideoPopularCell {
  struct ReuseIndentifier {
    static let imageCollectionCell = "ImageCollectionCell"
  }
}

extension VideoPopularCell: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let viewModel = viewModel else { return 0 }
    return viewModel.numberOfImages()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIndentifier.imageCollectionCell, for: indexPath) as? ImageCollectionCell, let viewModel = viewModel else {
      return UICollectionViewCell()
    }
    cell.viewModel = viewModel.getImages(at: indexPath)
    return cell
  }
}

extension VideoPopularCell: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width / numberOfImage, height: 100)
  }
}
