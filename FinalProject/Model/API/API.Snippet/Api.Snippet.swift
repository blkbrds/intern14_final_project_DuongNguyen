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

  }
  
  struct SnippetResult2 {
    var items: [Snippet]
    var token: String
  }

//  static func getSnippets(params: Api.Snippet.QueryParams, completion: @escaping Completion<SnippetResult>) {
//    let urlString = Api.Path.Snippet(token: params.token, keySearch: params.keySearch, maxResults: params.maxResults, keyID: params.keyID)
//    api.request(method: .get, urlString: urlString) { result in
//      DispatchQueue.main.async {
//        switch result {
//        case .success(let data):
//          guard let data = data as? JSObject,
//            let snippetResult = Mapper<SnippetResult>().map(JSON: data) else {
//              completion(.failure(Api.Error.json))
//              return
//          }
//          completion(.success(snippetResult))
//        case .failure(let error):
//          completion(.failure(error))
//        }
//      }
//    }
//  }
  
  static func getSnippet(keySearch: String, token: String, completion: APICompletion2<SnippetResult2>) {
    
  }
  
  static func getSnippetsTrending(token: String, completion: @escaping APICompletion2<SnippetResult2>) {
    let urlString = QueryParams().getTrendingPath(token: token)
    
    api.request(method: .get, urlString: urlString) { (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let data):
          guard let data = data as? JSObject,
            let snippetResult = Mapper<SnippetResult>().map(JSON: data) else {
              completion(.failure(Api.Error.json))
              return
          }
          
          let items = [Snippet]()
          let token = "asadasda"
          let snippetResult2 = SnippetResult2(items: items, token: token)
          
          completion(.success(snippetResult2))
          
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
  
}
