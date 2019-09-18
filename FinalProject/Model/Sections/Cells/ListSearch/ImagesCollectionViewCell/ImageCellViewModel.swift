//
//  ImageCellViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/3/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM

final class ImageCellViewModel: MVVM.ViewModel {

  // MARK: - Properties
  var videoImageView: String
  var titleOfVideoLabel: String

  // MARK: - Init
  init(model: Snippet) {
    self.videoImageView = model.thumbnails
    self.titleOfVideoLabel = model.title
  }
}
