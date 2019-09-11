//
//  Favorite.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/6/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

@objcMembers final class Favorite: Object, Mappable {

    @objc dynamic var kind: String? = ""
    @objc dynamic var videoId: String? = ""
    @objc dynamic var typeVideo = ""

    required convenience init?(map: Map) {
        self.init()
    }

    convenience init(json: JSObject) {
        var schema: [String: Any] = [:]
        if let kind = json["kind"] {
            schema["kind"] = kind
        }
        if let videoId = json["videoId"] {
            schema["videoId"] = videoId
        }
        self.init(value: schema)
    }

    func mapping(map: Map) {
        kind <- map["kind"]
        videoId <- map["videoId"]
        typeVideo <- map["typeVideo"]
    }
}