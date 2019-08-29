//
//  FavoriteViewController.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        title = "VIDEO YÊU THÍCH"
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
        navigationItem.rightBarButtonItem = deleteButton
    }
}
