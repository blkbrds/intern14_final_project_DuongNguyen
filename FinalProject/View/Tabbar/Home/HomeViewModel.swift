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
    private var snippets: Results<Snippet>?
    private var token: NotificationToken?
    // Temp channel list
//    var channels: [String] = []
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
        guard let channels = snippets else {
            fatalError("Please call `fetch()` first.")
        }
        return ChannelCellViewModel(channelImage: channels[indexPath.row].thumbnails, channelTitle: channels[indexPath.row].title, channelDescription: channels[indexPath.row].descript)
    }

    func numberOfRowInSection(in section: Int) -> Int {
        guard let section = SectionType(rawValue: section), let channels = snippets else { return 0 }
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

    enum SnippetResult {
        case success
        case failure
    }

    func getData() {
        imgArr = Dummy.imgArr
//        getSnippets(completion: <#HomeViewModel.GetSnippetCompletion#>)
        popVideos = Dummy.popVideos
    }

    func fetch() {
        guard itemsResponse == nil, snippets == nil else {
            return
        }
        do {
            try itemsResponse = Realm().objects(ItemsResponse.self)
            try snippets = Realm().objects(Snippet.self)
        } catch {
            itemsResponse = nil
            snippets = nil
        }
    }

    typealias GetSnippetCompletion = (SnippetResult) -> Void

    func getSnippets(completion: @escaping GetSnippetCompletion) {
        let params = Api.Snippet.QueryParams(
            token: "CBkQAA",
            keySearch: "Karaoke",
            keyID: "AIzaSyDIJ9UssMoN9IfR9KnTc4lb3B9NtHpRF-c"
        )
        Api.Snippet.query(params: params) { (result) in
            do {
                try Realm().refresh()
            } catch {
                print("can not refresh")
            }
            switch result {
            case .success(let data):
                if let dict = data as? JSObject {
                    guard let items = dict["items"] as? JSArray else {
                        return
                    }
                    DispatchQueue.main.async {
                        do {
                            let realm = try Realm()
                            try realm.write {
                                realm.deleteAll()
                                for item in items {
                                    guard let snip = item["snippet"] as? JSObject, let video = item["id"] as? JSObject else {
                                        return
                                    }
                                    realm.add(Snippet(json: snip))
                                    realm.add(Video(json: video))
                                    realm.add(ItemsResponse(json: item))
                                }
                            }
                        } catch {
                            print("KError with Realm")
                        }
                    }
                } else {
                    print("It's not")
                }
                completion(.success)
            case .failure(_):
                completion(.failure)
            }
        }
    }
}

struct Dummy {
    static let imgArr: [String] = ["img1", "img2", "img3", "img4", "img5"]
    static let popVideos: [String] = ["img1", "img2", "img3", "img4", "img5", "img1", "img2", "img3", "img4", "img5"]
}
