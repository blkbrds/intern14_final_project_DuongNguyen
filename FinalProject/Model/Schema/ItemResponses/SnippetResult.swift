//
//  SnippetResult.swift
//  FinalProject
//
//  Created by MBA0065 on 9/16/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

final class SnippetResult: Object, Mappable {

  @objc dynamic var nextPageToken: String? = ""
  var items: [ItemsResponse] = []

  required convenience init?(map: Map) {
    self.init()
  }

  convenience init(json: JSObject) {
    var schema: [String: Any] = [:]
    if let nextPageToken = json["nextPageToken"] {
      schema["nextPageToken"] = nextPageToken
    }
    if let items = json["items"] {
      schema["items"] = items
    }
    self.init(value: schema)
  }

  func mapping(map: Map) {
    nextPageToken <- map["nextPageToken"]
    items <- map["items"]
  }
}
