//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/3/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM
import RealmSwift
import SwiftyJSON

final class HomeViewModel: MVVM.ViewModel {

  // MARK: - Propeties
  var imgArr: [String] = []
  var popVideos: [String] = []
  var channels: [String] = []
  private var notificationToken: NotificationToken?

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
        return App.String.boleroTitle
      case .nhacXuan:
        return App.String.nhacXuanTitle
      case .nhacVang:
        return App.String.nhacVangTitle
      case .channel:
        return App.String.channelTitle
      }
    }

    var keySearch: String {
      switch self {
      case .bolero:
        return App.String.boleroKeySearch
      case .nhacXuan:
        return App.String.nhacXuanKeySearch
      case .nhacVang:
        return App.String.nhacVangKeySearch
      case .channel:
        return App.String.channelKeySearch
      case .trending:
        return App.String.trendingKeySearch
      }
    }
  }

  // MARK: - Public func
  func numberOfSections() -> Int {
    return SectionType.allCases.count
  }

  func getChannels(at indexPath: IndexPath) -> ChannelCellViewModel {
    return ChannelCellViewModel(channelImage: channels[indexPath.row], channelTitle: channels[indexPath.row], channelDescription: channels[indexPath.row])
  }

  private func numbersOfRowChannel() -> Int {
    return channels.count
  }

  func numberOfRowInSection(in section: Int) -> Int {
    guard let section = SectionType(rawValue: section) else { return 0 }
    switch section {
    case .trending, .bolero, .nhacVang, .nhacXuan:
      return Config.numberOfRowInSectionDefault
    default:
      return numbersOfRowChannel()
    }
  }

  func heightForRowAt(at indexPath: IndexPath) -> CGFloat {
    guard let section = SectionType(rawValue: indexPath.section) else { return 0 }
    switch section {
    case .trending:
      return Config.heightForRowOfTrending
    case .channel:
      return Config.heightForRowOfChannel
    default:
      return Config.heightForRowOfDefault
    }
  }
}

// MARK: - View Model
extension HomeViewModel {

  struct Config {
    static let heightForRowOfTrending: CGFloat = 200
    static let heightForRowOfChannel: CGFloat = 60
    static let heightForRowOfDefault: CGFloat = 100
    static let numberOfRowInSectionDefault: Int = 1
  }

  func makeVideoViewModel() -> VideoPopularCellViewModel {
    let vm = VideoPopularCellViewModel(imgArr: popVideos)
    return vm
  }

  func makeSliderViewModel() -> SliderCellViewModel {
    let vm = SliderCellViewModel(imgArr: imgArr)
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
