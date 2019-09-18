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
  var trendings: [Snippet] = []
  var videoTrendings: [Video] = []
  var trendingToken = ""

  var boleroes: [Snippet] = []
  var videoBoleroes: [Video] = []
  var boleroesToken = ""

  var nhacXuan: [Snippet] = []
  var videoNhacXuan: [Video] = []
  var nhacXuanToken = ""

  var nhacVang: [Snippet] = []
  var videoNhacVang: [Video] = []
  var nhacVangToken = ""

  var channels: [Snippet] = []
  var videoChannels: [Video] = []
  var channelsToken = ""

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
    return ChannelCellViewModel(model: channels[indexPath.row])
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

  func makeBoleroViewModel() -> VideoPopularCellViewModel {
    let vm = VideoPopularCellViewModel(snippets: boleroes)
    return vm
  }

  func makeNhacVangViewModel() -> VideoPopularCellViewModel {
    let vm = VideoPopularCellViewModel(snippets: nhacVang)
    return vm
  }

  func makeNhacXuanViewModel() -> VideoPopularCellViewModel {
    let vm = VideoPopularCellViewModel(snippets: nhacXuan)
    return vm
  }

  func makeSliderViewModel() -> SliderCellViewModel {
    let vm = SliderCellViewModel(snippets: trendings)
    return vm
  }
}

// MARK: - APIs
extension HomeViewModel {

  func loadTrending(completion: @escaping (Error?) -> Void) {
    Api.Snippet.getSnippetsTrending(token: App.String.token) { (result) in
      switch result {
      case .failure(let error):
        completion(error)
      case .success(let snippetResult):
        for snippet in snippetResult.items {
          if let snip = snippet.snippet {
            self.trendings.append(snip)
          }
        }
        if let nextPageToken = snippetResult.nextPageToken {
          self.trendingToken = nextPageToken
        }
        completion(nil)
      }
    }
  }

  func loadBolero(completion: @escaping (Error?) -> Void) {
    Api.Snippet.getSnippetsBolero(token: App.String.token) { (result) in
      switch result {
      case .failure(let error):
        completion(error)
      case .success(let snippetResult):
        for snippet in snippetResult.items {
          if let snip = snippet.snippet {
            self.boleroes.append(snip)
          }
        }
        if let nextPageToken = snippetResult.nextPageToken {
          self.boleroesToken = nextPageToken
        }
        completion(nil)
      }
    }
  }

  func loadNhacXuan(completion: @escaping (Error?) -> Void) {
    Api.Snippet.getSnippetsNhacXuan(token: App.String.token) { (result) in
      switch result {
      case .failure(let error):
        completion(error)
      case .success(let snippetResult):
        for snippet in snippetResult.items {
          if let snip = snippet.snippet {
            self.nhacXuan.append(snip)
          }
        }
        if let nextPageToken = snippetResult.nextPageToken {
          self.nhacXuanToken = nextPageToken
        }
        completion(nil)
      }
    }
  }

  func loadNhacVang(completion: @escaping (Error?) -> Void) {
    Api.Snippet.getSnippetsNhacVang(token: App.String.token) { (result) in
      switch result {
      case .failure(let error):
        completion(error)
      case .success(let snippetResult):
        for snippet in snippetResult.items {
          if let snip = snippet.snippet {
            self.nhacVang.append(snip)
          }
        }
        if let nextPageToken = snippetResult.nextPageToken {
          self.nhacVangToken = nextPageToken
        }
        completion(nil)
      }
    }
  }

  func loadChannel(completion: @escaping (Error?) -> Void) {
    Api.Snippet.getSnippetsChannel(token: App.String.token) { (result) in
      switch result {
      case .failure(let error):
        completion(error)
      case .success(let snippetResult):
        for snippet in snippetResult.items {
          if let snip = snippet.snippet {
            self.channels.append(snip)
          }
        }
        if let nextPageToken = snippetResult.nextPageToken {
          self.channelsToken = nextPageToken
        }
        completion(nil)
      }
    }
  }
}
