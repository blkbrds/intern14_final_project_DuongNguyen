//
//  SearchCellViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/9/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM

class SearchCellViewModel: MVVM.ViewModel {

    var titleLabel: String
    var imageView: String
    var channelLabel: String
    var viewsLabel: String

    init(titleLabel: String, imageView: String, channelLabel: String, viewsLabel: String = "0") {
        self.titleLabel = titleLabel
        self.imageView = imageView
        self.channelLabel = channelLabel
        self.viewsLabel = viewsLabel
    }
}
