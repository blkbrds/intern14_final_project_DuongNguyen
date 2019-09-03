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
    var channel: [String] = ["123", "456", "789"]

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

    func getChannels(at indexPath: IndexPath) -> ChannelViewModel {
        return ChannelViewModel(channelImage: "", channelTitle: channel[indexPath.row], channelDescription: channel[indexPath.row])
    }

    func numberOfRowInSection(in section: Int) -> Int {
        guard let section = SectionType(rawValue: section) else { return 0 }
        switch section {
        case .trending, .bolero, .nhacVang, .nhacXuan:
            return 1
        default:
            return channel.count
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
