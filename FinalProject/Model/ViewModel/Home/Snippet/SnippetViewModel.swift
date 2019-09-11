//
//  SnippetViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/4/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM

final class SnippetViewModel: MVVM.ViewModel {

    var publishedAt = ""
    var channelId = ""
    var title = ""
    var description = ""
    var thumbnails = ""
    var channelTitle = ""
    var liveBroadcastContent = ""

    init(snippet: Snippet?) {
        guard let snippet = snippet else { return }
        publishedAt = snippet.publishedAt
        channelId = snippet.channelId
        title = snippet.title
        description = snippet.descript
        thumbnails = snippet.thumbnails
        channelTitle = snippet.channelTitle
        liveBroadcastContent = snippet.liveBroadcastContent
    }
}
