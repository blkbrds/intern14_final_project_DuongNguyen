//
//  SliderImageCollectionViewCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import MVVM

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
    self.sliderImageView.image = UIImage(named: viewModel?.sliderImageView ?? "")
    self.sliderTitleVideoLabel.text = viewModel?.sliderTitleVideoLabel
  }
}
