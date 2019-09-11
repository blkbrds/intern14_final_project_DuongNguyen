//
//  ItemsResponse.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/4/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

@objcMembers final class ItemsResponse: Object, Mappable {

    @objc dynamic var kind: String? = ""
    @objc dynamic var etag: String? = ""
    @objc dynamic var id: Video?
    @objc dynamic var snippet: Snippet?

    required convenience init?(map: Map) {
        self.init()
    }

    convenience init(json: JSObject) {
        var schema: [String: Any] = [:]
        if let kind = json["kind"] {
            schema["kind"] = kind
        }
        if let etag = json["etag"] {
            schema["etag"] = etag
        }
        if let id = json["id"] as? Video {
            schema["id"] = id
        }
        if let snippet = json["snippet"] as? Snippet {
            schema["snippet"] = snippet
        }
        self.init(value: schema)
    }

    func mapping(map: Map) {
        kind <- map["kind"]
        etag <- map["etag"]
        id <- map["id"]
        snippet <- map["snippet"]
    }
}
