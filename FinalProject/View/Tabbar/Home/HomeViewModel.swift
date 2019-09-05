//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/3/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import RealmSwift
import MVVM
import SwiftyJSON

final class HomeViewModel: MVVM.ViewModel {

    // MARK: - Propeties
    weak var delegate: ViewModelDelegate?

    private var itemsResponse: Results<ItemsResponse>?
    private var snippets: [Snippet] = []
    private var boleroes: [Snippet] = []
    private var nhacXuan: [Snippet] = []
    private var nhacVang: [Snippet] = []
    private var trending: [Snippet] = []
    private var pageNextToken: String = ""

    private var token: NotificationToken?

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
                return "Nhạc xuân"
            case .nhacVang:
                return "Nhac vàng"
            case .channel:
                return "Channels"
            }
        }
    }
    // MARK: - Public func
    func numberOfSections() -> Int {
        return SectionType.allCases.count
    }

    func getChannels(at indexPath: IndexPath) -> ChannelCellViewModel {
        return ChannelCellViewModel(channelImage: snippets[indexPath.row].thumbnails, channelTitle: snippets[indexPath.row].channelTitle, channelDescription: snippets[indexPath.row].descript)
    }

    func numberOfRowInSection(in section: Int) -> Int {
        guard let section = SectionType(rawValue: section) else { return 0 }
        switch section {
        case .trending, .bolero, .nhacVang, .nhacXuan:
            return 1
        default:
            return snippets.count
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

    func makeSliderViewModel() -> SliderCellViewModel {
        return SliderCellViewModel(imgArr: trending)
    }

    func  makeVideoViewModel(for indexPath: IndexPath) -> VideoPopularCellViewModel {
        guard let section = SectionType(rawValue: indexPath.section) else { return VideoPopularCellViewModel() }
        switch section {
        case .bolero:
            return VideoPopularCellViewModel(imgArr: boleroes)
        case .nhacVang:
            return VideoPopularCellViewModel(imgArr: nhacVang)
        case .nhacXuan:
            return VideoPopularCellViewModel(imgArr: nhacXuan)
        case .channel, .trending:
            return VideoPopularCellViewModel()
        }
    }
}

// MARK: - View Model
extension HomeViewModel {
}

// MARK: - APIs
extension HomeViewModel {

    enum SnippetResult {
        case success
        case failure
    }

    func getSnippets(keySearch: HomeViewController.Search.KeySearch, maxResults: Int, completion: @escaping APICompletion) {
        let params = Api.Snippet.QueryParams(
            token: "CBkQAA",
            keySearch: keySearch.key,
            maxResults: maxResults,
            keyID: "AIzaSyDzfgQXDhXWMwgIhTiQDD7r5PAvPGXETRg"
        )
        Api.Snippet.getSnippets(params: params) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let snippetResult):
                for snippet in snippetResult.items {
                    if let snip = snippet.snippet {
                        switch keySearch {
                        case .channel:
                            self.snippets.append(snip)
                        case .bolero:
                            self.boleroes.append(snip)
                        case .nhacXuan:
                            self.nhacXuan.append(snip)
                        case .nhacVang:
                            self.nhacVang.append(snip)
                        case .trending:
                            self.trending.append(snip)
                        }
                    }
                }
                self.pageNextToken = snippetResult.nextPageToken ?? ""
                completion(.success)
            }
        }
    }
}
