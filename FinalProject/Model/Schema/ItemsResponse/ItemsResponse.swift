//
//  ItemsResponse.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/4/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import RealmSwift

final class ItemsResponse: Object {

    typealias JSON = [String: Any]

    @objc dynamic var kind: String? = ""
    @objc dynamic var etag: String? = ""
    @objc dynamic var id: Video?
    @objc dynamic var snippet: Snippet?

    convenience init(json: JSON) {
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
}
