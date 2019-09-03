//
//  ChannelViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/3/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM

class ChannelViewModel: MVVM.ViewModel {
    var channelImage: String
    var channelTitle: String
    var channelDescription: String

    init(channelImage: String = "", channelTitle: String = "", channelDescription: String = "") {
        self.channelImage = channelImage
        self.channelTitle = channelTitle
        self.channelDescription = channelDescription
    }
}
