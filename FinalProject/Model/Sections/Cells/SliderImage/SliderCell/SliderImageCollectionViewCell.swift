//
//  SliderImageCollectionViewCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import SDWebImage

final class SliderImageCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak private var sliderImageView: UIImageView!
    @IBOutlet weak private var sliderTitleVideoLabel: UILabel!

    var viewModel = SliderImageCellViewModel() {
        didSet {
            updateUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateUI() {
        self.sliderImageView.sd_setImage(with: URL(string: viewModel.sliderImageView), placeholderImage: #imageLiteral(resourceName: "img-youtube"))
        self.sliderTitleVideoLabel.text = viewModel.sliderTitleVideoLabel
    }
}
