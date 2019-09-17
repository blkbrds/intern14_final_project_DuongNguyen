//
//  Snippet.swift
//  FinalProject
//
//  Created by MBA0065 on 9/16/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

@objcMembers final class Snippet: Object, Mappable {

  @objc dynamic var publishedAt = ""
  @objc dynamic var channelId = ""
  @objc dynamic var title = ""
  @objc dynamic var descript = ""
  @objc dynamic var thumbnails = ""
  @objc dynamic var channelTitle = ""
  @objc dynamic var liveBroadcastContent = ""
  @objc dynamic var typeVideo = ""

  required convenience init?(map: Map) {
    self.init()
  }

  convenience init(json: JSObject) {
    var schema: [String: Any] = [:]
    if let publishedAt = json["publishedAt"] {
      schema["publishedAt"] = publishedAt
    }
    if let channelId = json["channelId"] {
      schema["channelId"] = channelId
    }
    if let title = json["title"] {
      schema["title"] = title
    }
    if let defaultUrl = json["thumbnails"] as? JSObject {
      if let thumb = defaultUrl["medium"] as? JSObject {
        if let thumbUrl = thumb["url"] {
          schema["thumbnails"] = thumbUrl
        }
      }
    }
    if let description = json["description"] {
      schema["descript"] = description
    }
    if let channelTitle = json["channelTitle"] {
      schema["channelTitle"] = channelTitle
    }
    if let liveBroadcastContent = json["liveBroadcastContent"] {
      schema["liveBroadcastContent"] = liveBroadcastContent
    }
    self.init(value: schema)
  }

  func mapping(map: Map) {
    publishedAt <- map["publishedAt"]
    channelId <- map["channelId"]
    title <- map["title"]
    descript <- map["description"]
    thumbnails <- map["thumbnails.medium.url"]
    channelTitle <- map["channelTitle"]
    liveBroadcastContent <- map["liveBroadcastContent"]
    typeVideo <- map["typeVideo"]
  }
}
