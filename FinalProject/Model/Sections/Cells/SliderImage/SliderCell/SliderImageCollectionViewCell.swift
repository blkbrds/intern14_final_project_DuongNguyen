//
//  SliderImageCollectionViewCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import MVVM
import SDWebImage

final class SliderImageCollectionViewCell: UICollectionViewCell, MVVM.View {

  // MARK: - Outlets
  @IBOutlet weak private var sliderImageView: UIImageView!
  @IBOutlet weak private var sliderTitleVideoLabel: UILabel!

  // MARK: - Properties
  var viewModel: SliderImageCellViewModel? {
    didSet {
      updateView()
    }
  }

  // MARK: - Life cycles
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  // MARK: - Custom func
  func updateView() {
    guard let viewModel = viewModel else { return }
    self.sliderImageView.sd_setImage(with: URL(string: viewModel.sliderImageView), placeholderImage: #imageLiteral(resourceName: "img3"))
    self.sliderTitleVideoLabel.text = viewModel.sliderTitleVideoLabel
  }
}
