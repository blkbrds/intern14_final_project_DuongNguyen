//
//  CollectionViewCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var titleOfVideoLabel: UILabel!

    // MARK: - Properties
    var viewModel = ImageViewCellModel() {
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
