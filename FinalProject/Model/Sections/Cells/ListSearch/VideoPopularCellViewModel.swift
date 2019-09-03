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
    let imgArr: [String]

    init(imgArr: [String] = []) {
        self.imgArr = imgArr
    }

    func numberOfImages() -> Int {
        return imgArr.count
    }

    func getImages(at indexPath: IndexPath) -> ImageCellViewModel {
        return ImageCellViewModel(videoImageView: imgArr[indexPath.row], titleOfVideoLabel: imgArr[indexPath.row])
    }
}
