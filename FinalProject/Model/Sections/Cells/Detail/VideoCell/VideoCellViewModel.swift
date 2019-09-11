//
//  VideoCellViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/5/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM

final class VideoCellViewModel: MVVM.ViewModel {

    // MARK: - Properties
    var videoId: String

    // MARK: - Init
    init(videoId: String = "") {
        self.videoId = videoId
    }
}
