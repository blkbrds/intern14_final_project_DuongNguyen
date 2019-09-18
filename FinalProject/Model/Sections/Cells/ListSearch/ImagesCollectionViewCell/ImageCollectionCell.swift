//
//  ImageCollectionCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import MVVM

final class ImageCollectionCell: UICollectionViewCell, MVVM.View {

  // MARK: - Outlets
  @IBOutlet weak private var videoImageView: UIImageView!
  @IBOutlet weak private var titleOfVideoLabel: UILabel!

  // MARK: - Properties
  var viewModel: ImageCellViewModel? {
    didSet {
      updateUI()
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    updateUI()
  }

  private func updateUI() {
    guard let viewModel = viewModel else { return }
    self.videoImageView.sd_setImage(with: URL(string: viewModel.videoImageView), placeholderImage: #imageLiteral(resourceName: "img3"))
    self.titleOfVideoLabel.text = viewModel.titleOfVideoLabel
  }
}
