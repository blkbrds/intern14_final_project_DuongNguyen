//
//  SliderCellViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/3/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM

final class SliderCellViewModel: MVVM.ViewModel {

  // Temp list image
  let snippets: [Snippet]

  init(snippets: [Snippet] = []) {
    self.snippets = snippets
  }

  func numberOfImages() -> Int {
    return snippets.count
  }

  func getSliderImages(at indexPath: IndexPath) -> SliderImageCellViewModel {
      return SliderImageCellViewModel(model: snippets[indexPath.row])
  }
}
