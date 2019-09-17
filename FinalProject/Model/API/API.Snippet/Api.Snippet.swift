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
    let token: String
    let keySearch: String
    let maxResults: Int
    let keyID: String
  }

  static func getSnippets(params: Api.Snippet.QueryParams, completion: @escaping Completion<SnippetResult>) {
    let urlString = Api.Path.Snippet(token: params.token, keySearch: params.keySearch, maxResults: params.maxResults, keyID: params.keyID)
    api.request(method: .get, urlString: urlString) { result in
      DispatchQueue.main.async {
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
