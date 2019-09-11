//
//  VideoCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/30/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

final class VideoCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak private var videoWebView: UIWebView!

    // MARK: - Properties
    var viewModel = VideoCellViewModel() {
        didSet {
            updateUI()
        }
    }

    // MARK: - Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Custom funcs
    private func getVideo(videoKey: String) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoKey)")
        if let url = url {
            videoWebView.loadRequest(URLRequest(url: url))
        }
    }

    private func updateUI() {
        getVideo(videoKey: viewModel.videoId)
    }
}
