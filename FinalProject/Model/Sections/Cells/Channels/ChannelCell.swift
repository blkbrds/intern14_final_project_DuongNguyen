//
//  ChannelCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import MVVM

class ChannelCell: UITableViewCell, MVVM.View {

    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var channelDescriptionLabel: UILabel!

    var viewModel = ChannelViewModel() {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func updateUI() {
        self.channelImageView.image = UIImage(named: viewModel.channelImage)
        self.channelTitleLabel.text = viewModel.channelTitle
        self.channelDescriptionLabel.text = viewModel.channelDescription
    }
}
