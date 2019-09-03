//
//  ImageCollectionCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var titleOfVideoLabel: UILabel!

    // MARK: - Properties
    var viewModel = ImageCellViewModel() {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func updateUI() {
        self.videoImageView.image = UIImage(named: viewModel.videoImageView)
        self.titleOfVideoLabel.text = viewModel.titleOfVideoLabel
    }
}
