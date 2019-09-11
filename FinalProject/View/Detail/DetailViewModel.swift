//
//  DetailViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/5/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import MVVM
import Realm
import RealmSwift

final class DetailViewModel: MVVM.ViewModel {

    // MARK: - Propeties
    weak var delegate: ViewModelDelegate?

    func heightForRowAt() -> CGFloat {
        return 200
    }

    func getVideo(video: Video) -> VideoCellViewModel {
        return VideoCellViewModel(videoId: video.videoId ?? "")
    }

    func addFavoriteVideo(json: Object) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(json)
                }
            } catch {
                print("KError with Realm")
            }
        }
    }

    func removeFavoriteVideo(json: Favorite) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                let item = realm.objects(Favorite.self).filter("videoId = %@", json.videoId as Any).first
                try realm.write {
                    if let obj = item {
                        realm.delete(obj)
                    }
                }
            } catch {
                print("KError with Realm")
            }
        }
    }

    func isFavorite(json: Favorite) -> Bool {
        var item: Favorite?
//        DispatchQueue.main.async {
        do {
            let realm = try Realm()
            item = realm.objects(Favorite.self).filter("videoId = %@", json.videoId as Any).first
        } catch {
            print("KError with Realm")
        }
        //        }
        return item != nil ? true : false
    }
}
