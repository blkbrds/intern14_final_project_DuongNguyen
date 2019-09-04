//
//  ChannelCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import MVVM
import SDWebImage

final class ChannelCell: UITableViewCell, MVVM.View {

    @IBOutlet weak private var channelImageView: UIImageView!
    @IBOutlet weak private var channelTitleLabel: UILabel!
    @IBOutlet weak private var channelDescriptionLabel: UILabel!

    var viewModel = ChannelCellViewModel() {
        didSet {
            setupUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setupUI() {
        // use lib SDWebImage
        self.channelImageView.sd_setImage(with: URL(string: viewModel.channelImage), placeholderImage: UIImage(named: "youtube"))
        self.channelTitleLabel.text = viewModel.channelTitle
        self.channelDescriptionLabel.text = viewModel.channelDescription
    }
}
