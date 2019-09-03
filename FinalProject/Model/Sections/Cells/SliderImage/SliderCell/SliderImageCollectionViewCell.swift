//
//  SliderImageCollectionViewCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

class SliderImageCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var sliderImageView: UIImageView!
    @IBOutlet weak var sliderTitleVideoLabel: UILabel!

    var viewModel = SliderImageCellViewModel() {
        didSet {
            updateUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateUI() {
        self.sliderImageView.image = UIImage(named: viewModel.sliderImageView)
        self.sliderTitleVideoLabel.text = viewModel.sliderTitleVideoLabel
    }
}
