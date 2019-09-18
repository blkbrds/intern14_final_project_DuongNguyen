//
//  SliderImageViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/3/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM

final class SliderImageCellViewModel: MVVM.ViewModel {

  // MARK: - Properties
  var sliderImageView: String
  var sliderTitleVideoLabel: String

  init(model: Snippet) {
    self.sliderImageView = model.thumbnails
    self.sliderTitleVideoLabel = model.title
  }
}
