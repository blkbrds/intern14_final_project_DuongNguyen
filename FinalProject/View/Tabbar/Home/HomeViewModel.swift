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
    var list: [Snippet] = []
    var vd: [Video] = []
    var snippets: [Snippet] = []
    var videoChannel: [Video] = []
    var boleroes: [Snippet] = []
    var videoBoleros: [Video] = []
    var nhacXuan: [Snippet] = []
    var videoNhacXuan: [Video] = []
    var nhacVang: [Snippet] = []
    var videoNhacVang: [Video] = []
    var trending: [Snippet] = []
    var videoTrending: [Video] = []
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

    func makeVideoViewModel(for indexPath: IndexPath) -> VideoPopularCellViewModel {
        guard let section = SectionType(rawValue: indexPath.section) else { return VideoPopularCellViewModel() }
        switch section {
        case .bolero:
            return VideoPopularCellViewModel(imgArr: boleroes, index: indexPath.section)
        case .nhacVang:
            return VideoPopularCellViewModel(imgArr: nhacVang, index: indexPath.section)
        case .nhacXuan:
            return VideoPopularCellViewModel(imgArr: nhacXuan, index: indexPath.section)
        case .channel, .trending:
            return VideoPopularCellViewModel()
        }
    }
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
            keyID: "AIzaSyBgNGrJqNPgSkUOrI_WdmMKTW-NeBvAKjQ"
        )
        Api.Snippet.getSnippets(params: params) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let snippetResult):
                for snippet in snippetResult.items {
                    if let snip = snippet.snippet, let video = snippet.id {
                        switch keySearch {
                        case .channel:
                            snip.typeVideo = keySearch.key
                            video.typeVideo = keySearch.key
                            // self.writeRealm(jsArray: snip)
                            // self.writeRealm(jsArray: video)
                            self.vd.append(video)
                            self.list.append(snip)
                            // self.snippets.append(snip)
                        case .bolero:
                            snip.typeVideo = keySearch.key
                            video.typeVideo = keySearch.key
//                            self.writeRealm(jsArray: snip)
//                            self.writeRealm(jsArray: video)
//                            self.videoBoleros.append(video)
//                            self.boleroes.append(snip)
                            self.vd.append(video)
                            self.list.append(snip)
                        case .nhacXuan:
                            snip.typeVideo = keySearch.key
                            video.typeVideo = keySearch.key
//                            self.writeRealm(jsArray: snip)
//                            self.writeRealm(jsArray: video)
//                            self.nhacXuan.append(snip)
                            self.vd.append(video)
                            self.list.append(snip)
                        case .nhacVang:
                            snip.typeVideo = keySearch.key
                            video.typeVideo = keySearch.key
//                            self.writeRealm(jsArray: snip)
//                            self.writeRealm(jsArray: video)
//                            self.nhacVang.append(snip)
                            self.vd.append(video)
                            self.list.append(snip)
                        case .trending:
                            snip.typeVideo = keySearch.key
                            video.typeVideo = keySearch.key
//                            self.writeRealm(jsArray: snip)
//                            self.writeRealm(jsArray: video)
//                            self.trending.append(snip)
                            self.vd.append(video)
                            self.list.append(snip)
                        }
                    }
                }
                self.writeRealm(jsArray: self.list)
                self.writeRealm(jsArray: self.vd)
                self.pageNextToken = snippetResult.nextPageToken ?? ""
                completion(.success)
            }
        }
    }

    func writeRealm(jsArray: [Object]) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                try realm.write {
                    for item in jsArray {
                        realm.add(item)
                    }
                }
            } catch {
                print("KError with Realm")
            }
        }
    }

    func fetchData() {
        do {
            let snippetsFilter = NSPredicate(format: "typeVideo == %@", String("karaoke"))
            let boleroesFilter = NSPredicate(format: "typeVideo == %@", String("bolero"))
            let nhacXuanFilter = NSPredicate(format: "typeVideo == %@", String("nhacxuan"))
            let nhacVangFilter = NSPredicate(format: "typeVideo == %@", String("nhacvang"))
            let trendingFilter = NSPredicate(format: "typeVideo == %@", String(""))
            try snippets = Realm().objects(Snippet.self).filter(snippetsFilter).toArray(type: Snippet.self)
            try videoChannel = Realm().objects(Video.self).filter(snippetsFilter).toArray(type: Video.self)
            try boleroes = Realm().objects(Snippet.self).filter(boleroesFilter).toArray(type: Snippet.self)
            try videoBoleros = Realm().objects(Video.self).filter(boleroesFilter).toArray(type: Video.self)
            try nhacXuan = Realm().objects(Snippet.self).filter(nhacXuanFilter).toArray(type: Snippet.self)
            try videoNhacXuan = Realm().objects(Video.self).filter(nhacXuanFilter).toArray(type: Video.self)
            try nhacVang = Realm().objects(Snippet.self).filter(nhacVangFilter).toArray(type: Snippet.self)
            try videoNhacVang = Realm().objects(Video.self).filter(nhacVangFilter).toArray(type: Video.self)
            try trending = Realm().objects(Snippet.self).filter(trendingFilter).toArray(type: Snippet.self)
            try videoTrending = Realm().objects(Video.self).filter(trendingFilter).toArray(type: Video.self)
        } catch {
            snippets = []
            videoChannel = []
            boleroes = []
            videoBoleros = []
            nhacXuan = []
            videoNhacXuan = []
            nhacVang = []
            videoNhacVang = []
            trending = []
            videoTrending = []
        }
    }
}

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
