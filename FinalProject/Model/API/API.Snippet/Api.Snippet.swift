//
//  Api.Snippet.swift
//  FinalProject
//
//  Created by MBA0065 on 9/16/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RealmSwift

extension Api.Snippet {

  struct QueryParams {
    let keyID: String = "AIzaSyBgNGrJqNPgSkUOrI_WdmMKTW-NeBvAKjQ"

    func getTrendingPath(token: String) -> String {
      return Api.Path.Snippet(token: token, keySearch: App.String.trendingKeySearch, maxResults: App.Number.maxResultOfTrending, keyID: self.keyID).urlString
    }

    func getBoleroPath(token: String) -> String {
      return Api.Path.Snippet(token: token, keySearch: App.String.boleroKeySearch, maxResults: App.Number.maxResultDefault, keyID: self.keyID).urlString
    }

    func getNhacXuanPath(token: String) -> String {
      return Api.Path.Snippet(token: token, keySearch: App.String.nhacXuanKeySearch, maxResults: App.Number.maxResultDefault, keyID: self.keyID).urlString
    }

    func getNhacVangPath(token: String) -> String {
      return Api.Path.Snippet(token: token, keySearch: App.String.nhacVangKeySearch, maxResults: App.Number.maxResultDefault, keyID: self.keyID).urlString
    }

    func getChannelPath(token: String) -> String {
      return Api.Path.Snippet(token: token, keySearch: App.String.channelKeySearch, maxResults: App.Number.maxResultDefault, keyID: self.keyID).urlString
    }
  }

  static func getSnippetsTrending(token: String, completion: @escaping Completion<SnippetResult>) {
    let urlString = QueryParams().getTrendingPath(token: token)
    api.request(method: .get, urlString: urlString) { (result) in
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        switch result {
        case .success(let data):
          guard let data = data as? JSObject,
            let snippetResult = Mapper<SnippetResult>().map(JSON: data) else {
              completion(.failure(Api.Error.json))
              return
          }
          completion(.success(snippetResult))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }

  static func getSnippetsBolero(token: String, completion: @escaping Completion<SnippetResult>) {
    let urlString = QueryParams().getBoleroPath(token: token)
    api.request(method: .get, urlString: urlString) { (result) in
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        switch result {
        case .success(let data):
          guard let data = data as? JSObject,
            let snippetResult = Mapper<SnippetResult>().map(JSON: data) else {
              completion(.failure(Api.Error.json))
              return
          }
          completion(.success(snippetResult))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }

  static func getSnippetsNhacVang(token: String, completion: @escaping Completion<SnippetResult>) {
    let urlString = QueryParams().getNhacVangPath(token: token)
    api.request(method: .get, urlString: urlString) { (result) in
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        switch result {
        case .success(let data):
          guard let data = data as? JSObject,
            let snippetResult = Mapper<SnippetResult>().map(JSON: data) else {
              completion(.failure(Api.Error.json))
              return
          }
          completion(.success(snippetResult))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }

  static func getSnippetsNhacXuan(token: String, completion: @escaping Completion<SnippetResult>) {
    let urlString = QueryParams().getNhacXuanPath(token: token)
    api.request(method: .get, urlString: urlString) { (result) in
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
        switch result {
        case .success(let data):
          guard let data = data as? JSObject,
            let snippetResult = Mapper<SnippetResult>().map(JSON: data) else {
              completion(.failure(Api.Error.json))
              return
          }
          completion(.success(snippetResult))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }

  static func getSnippetsChannel(token: String, completion: @escaping Completion<SnippetResult>) {
    let urlString = QueryParams().getChannelPath(token: token)
    api.request(method: .get, urlString: urlString) { (result) in
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        switch result {
        case .success(let data):
          guard let data = data as? JSObject,
            let snippetResult = Mapper<SnippetResult>().map(JSON: data) else {
              completion(.failure(Api.Error.json))
              return
          }
          completion(.success(snippetResult))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
