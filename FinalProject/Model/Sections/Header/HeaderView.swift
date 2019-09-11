//
//  HeaderView.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

final class HeaderView: UITableViewHeaderFooterView {

    // MARK: - Outlets
    @IBOutlet private weak var keySearchLabel: UILabel!

    func updateUI(title: String?) {
        keySearchLabel.text = title
    }

    @IBAction func moreButtonTouchUpInside(_ button: UIButton) {
    // Todo
    }
}
