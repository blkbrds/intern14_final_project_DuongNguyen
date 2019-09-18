//
//  SearchCellViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/3/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM

final class VideoPopularCellViewModel: MVVM.ViewModel {

  // Temp list image
  let snippets: [Snippet]

  init(snippets: [Snippet] = []) {
    self.snippets = snippets
  }

  func numberOfImages() -> Int {
    return snippets.count
  }

  func getImages(at indexPath: IndexPath) -> ImageCellViewModel {
    return ImageCellViewModel(model: snippets[indexPath.row])
  }
}
