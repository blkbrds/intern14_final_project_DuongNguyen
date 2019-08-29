//
//  ListSearchCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

class ListSearchCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Custom funcs
    private func configCollectionView() {
        let cellNib = UINib(nibName: "CollectionViewCell", bundle: Bundle.main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setUpColectionView() {
    }
}

// MARK: - Extensions
extension ListSearchCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension ListSearchCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 4, height: 100)
    }
}
