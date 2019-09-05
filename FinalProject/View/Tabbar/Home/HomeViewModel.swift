//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/3/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM

final class HomeViewModel: MVVM.ViewModel {

    // MARK: - Propeties
    // Temp channel list
    var channels: [String] = []
    var imgArr: [String] = []
    var popVideos: [String] = []

    enum SectionType: Int, CaseIterable {
        case trending
        case bolero
        case nhacXuan
        case nhacVang
        case channel

        var title: String? {
            switch self {
            case .trending:
                return nil
            case .bolero:
                return "Bolero"
            case .nhacXuan:
                return "Nhac xuan"
            case .nhacVang:
                return "Nhac vang"
            case .channel:
                return "Channel"
            }
        }
    }

    // MARK: - Public func
    func numberOfSections() -> Int {
        return SectionType.allCases.count
    }

    func getChannels(at indexPath: IndexPath) -> ChannelCellViewModel {
        return ChannelCellViewModel(channelImage: "", channelTitle: channels[indexPath.row], channelDescription: channels[indexPath.row])
    }

    func numberOfRowInSection(in section: Int) -> Int {
        guard let section = SectionType(rawValue: section) else { return 0 }
        switch section {
        case .trending, .bolero, .nhacVang, .nhacXuan:
            return 1
        default:
            return channels.count
        }
    }

    func heightForRowAt(at indexPath: IndexPath) -> CGFloat {
        guard let section = SectionType(rawValue: indexPath.section) else { return 0 }
        switch section {
        case .trending:
            return 200
        case .channel:
            return 60
        default:
            return 100
        }
    }
}

// MARK: - View Model
extension HomeViewModel {

    func makeSliderViewModel() -> SliderCellViewModel {
        let vm = SliderCellViewModel(imgArr: imgArr)
        return vm
    }

    func  makeVideoViewModel() -> VideoPopularCellViewModel {
        let vm = VideoPopularCellViewModel(imgArr: popVideos)
        return vm
    }
}

// MARK: - APIs
extension HomeViewModel {

    func getData() {
        imgArr = Dummy.imgArr
        channels = Dummy.channels
        popVideos = Dummy.popVideos
    }
}

struct Dummy {
    static let imgArr: [String] = ["img1", "img2", "img3", "img4", "img5"]
    static let channels: [String] = ["123", "456", "789", "123", "456", "789", "123", "456", "789"]
    static let popVideos: [String] = ["img1", "img2", "img3", "img4", "img5", "img1", "img2", "img3", "img4", "img5"]
}
