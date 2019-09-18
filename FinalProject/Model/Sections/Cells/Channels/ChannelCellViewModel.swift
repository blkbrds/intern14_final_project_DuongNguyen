//
//  ChannelCellViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/3/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM

final class ChannelCellViewModel: MVVM.ViewModel {

  var channelImage: String
  var channelTitle: String
  var channelDescription: String

  init(model: Snippet) {
    self.channelImage = model.thumbnails
    self.channelTitle = model.title
    self.channelDescription = model.descript
  }
}
