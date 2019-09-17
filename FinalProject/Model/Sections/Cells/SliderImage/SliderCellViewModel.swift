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

//  let imgArr: [ItemsResponse]
//
//  init(imgArr: [ItemsResponse] = []) {
//    self.imgArr = imgArr
//  }
  let imgArr: [String]

  init(imgArr: [String] = []) {
    self.imgArr = imgArr
  }

  // MARK: - Custom funcs
  func numberOfImages() -> Int {
    if imgArr.isEmpty {
      return 0
    }
    return imgArr.count
  }

//  func getSliderImages(at indexPath: IndexPath) -> SliderImageCellViewModel {
//    guard let snippet = imgArr[indexPath.row].snippet else { return SliderImageCellViewModel(sliderImageView: App.String.imageDefault, sliderTitleVideoLabel: App.String.titleDefault) }
//    return SliderImageCellViewModel(sliderImageView: snippet.thumbnails, sliderTitleVideoLabel: snippet.title)
//  }
  func getSliderImages(at indexPath: IndexPath) -> SliderImageCellViewModel {
    return SliderImageCellViewModel(sliderImageView: imgArr[indexPath.row], sliderTitleVideoLabel: imgArr[indexPath.row])
  }
}
