//
//  ImagesViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/3/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM

class ImagesViewModel: MVVM.ViewModel {

    // Temp list image
    var imgArr = ["img1", "img2", "img3", "img4", "img5", "img1", "img2", "img3", "img4", "img5"]

    func numberOfImages() -> Int {
        return imgArr.count
    }

    func getImages(at indexPath: IndexPath) -> ImageViewCellModel {
        return ImageViewCellModel(videoImageView: imgArr[indexPath.row], titleOfVideoLabel: imgArr[indexPath.row])
    }
}
