//
//  ImageViewCellModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/3/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM

class ImageViewCellModel: MVVM.ViewModel {

    // MARK: - Properties
    var videoImageView: String
    var titleOfVideoLabel: String

    // MARK: - Init
    init(videoImageView: String = "", titleOfVideoLabel: String = "") {
        self.videoImageView = videoImageView
        self.titleOfVideoLabel = titleOfVideoLabel
    }
}
