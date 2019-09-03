//
//  SliderViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/3/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM

class SliderViewModel: MVVM.ViewModel {

    // Temp list image
    var imgArr = ["img1", "img2", "img3", "img4", "img5"]

    func numberOfImages() -> Int {
        return imgArr.count
    }
    func getSliderImages(at indexPath: IndexPath) -> SliderImageViewModel {
        return SliderImageViewModel(sliderImageView: imgArr[indexPath.row], sliderTitleVideoLabel: imgArr[indexPath.row])
    }
}
