//
//  SliderImageViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/3/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM

final class SliderImageCellViewModel: MVVM.ViewModel {

    var sliderImageView: String
    var sliderTitleVideoLabel: String

    init(sliderImageView: String = "", sliderTitleVideoLabel: String = "") {
        self.sliderImageView = sliderImageView
        self.sliderTitleVideoLabel = sliderTitleVideoLabel
    }
}
