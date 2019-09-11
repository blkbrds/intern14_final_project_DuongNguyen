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
    let imgArr: [Snippet]

    init(imgArr: [Snippet] = []) {
        self.imgArr = imgArr
    }

    func numberOfImages() -> Int {
        return imgArr.count
    }
    func getSliderImages(at indexPath: IndexPath) -> SliderImageCellViewModel {
        return SliderImageCellViewModel(sliderImageView: imgArr[indexPath.row].thumbnails,
                                    sliderTitleVideoLabel: imgArr[indexPath.row].title)
    }
}
