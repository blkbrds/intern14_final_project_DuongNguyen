//
//  ChannelCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import MVVM

final class ChannelCell: UITableViewCell, MVVM.View {

  // MARK: - Outlets
  @IBOutlet weak private var channelImageView: UIImageView!
  @IBOutlet weak private var channelTitleLabel: UILabel!
  @IBOutlet weak private var channelDescriptionLabel: UILabel!

  var viewModel: ChannelCellViewModel? {
    didSet {
      setupUI()
    }
  }

  // MARK: - Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  // MARK: - Custom func
  private func setupUI() {
    // use lib SDWebImage
//        self.channelImageView.sd_setImage(with: URL(string: viewModel.channelImage), placeholderImage: UIImage(named: "youtube"))
    self.channelImageView.image = UIImage(named: viewModel?.channelImage ?? "")
    self.channelTitleLabel.text = viewModel?.channelTitle
    self.channelDescriptionLabel.text = viewModel?.channelDescription
  }
}
