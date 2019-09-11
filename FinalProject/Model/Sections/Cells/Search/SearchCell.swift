//
//  SearchCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/30/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import SDWebImage
import MVVM

final class SearchCell: UITableViewCell, MVVM.View {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak private var channelImageView: UIImageView!
    @IBOutlet weak private var channelLabel: UILabel!
    @IBOutlet weak private var viewsLabel: UILabel!

    // MARK: - Properties
    var viewModel: SearchCellViewModel? {
        didSet {
            setUpUI()
        }
    }

    // MARK: - Life cycles
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Custom Func
    func setUpUI() {
        guard let viewModel = viewModel else {
            return
        }
        self.titleLabel.text = viewModel.titleLabel
        self.channelImageView.sd_setImage(with: URL(string: viewModel.imageView), placeholderImage: #imageLiteral(resourceName: "img-youtube"))
        self.channelLabel.text = viewModel.channelLabel
        self.viewsLabel.text = viewModel.viewsLabel
    }
}
