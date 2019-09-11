//
//  FavoriteViewModel.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/9/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import RealmSwift
import MVVM

class FavoriteViewModel: MVVM.ViewModel {

    private var favorites: Results<Favorite>?
    private var favoriteList: [Favorite] = []

    func numberOfItems() -> Int {
        guard let favorites = favorites else {
            return 0
        }
        return favorites.count
    }

//    func makeSearchCell(at indexPath: IndexPath) -> SearchCellViewModel {
//        guard let favorites = favorites else {
//            return SearchCellViewModel(titleLabel: "", imageView: "", channelLabel: "")
//        }
//        favoriteList = favorites.toArray(type: Favorite.self)
//        return SearchCellViewModel(titleLabel: , imageView: <#T##String#>, channelLabel: <#T##String#>, viewsLabel: <#T##String#>)
//    }
}
