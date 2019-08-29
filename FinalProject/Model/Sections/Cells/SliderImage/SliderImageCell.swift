//
//  SliderImageCell.swift
//  FinalProject
//
//  Created by Nguyen Duong on 8/29/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

class SliderImageCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!

    // MARK: - properties
    // Temp list image
    var imgArr = [#imageLiteral(resourceName: "img2"), #imageLiteral(resourceName: "img1"), #imageLiteral(resourceName: "img5"), #imageLiteral(resourceName: "img4"), #imageLiteral(resourceName: "img3")]

    private var timer = Timer()
    private var counter = 0
    // MARK: - Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        configPageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Custom funcs
    private func configCollectionView() {
        let cellNib = UINib(nibName: "SliderImageCollectionViewCell", bundle: Bundle.main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "SliderImageCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func configPageView() {
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }

    @objc func changeImage() {
        if counter < imgArr.count {
            let index = IndexPath(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
    }
}

// MARK: - Extensions
extension SliderImageCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderImageCollectionViewCell", for: indexPath) as? SliderImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.imageSlider.image = imgArr[indexPath.row]
        return cell
    }
}

extension SliderImageCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 200)
    }
}