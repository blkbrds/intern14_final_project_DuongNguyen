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
    let imgArr: [Snippet]
    let index: Int

    init(imgArr: [Snippet] = [], index: Int = 0) {
        self.imgArr = imgArr
        self.index = index
    }

    func numberOfImages() -> Int {
        return imgArr.count
    }

    func getImages(at indexPath: IndexPath) -> ImageCellViewModel {
        return ImageCellViewModel(videoImageView: imgArr[indexPath.row].thumbnails, titleOfVideoLabel: imgArr[indexPath.row].title)
    }
}
