//
//  Api.Snippet.swift
//  FinalProject
//
//  Created by Nguyen Duong on 9/4/19.
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
        let keyID: String
    }

    @discardableResult
    static func query(params: Api.Snippet.QueryParams, completion: @escaping CompletionSnippet) -> Request? {
        let path = Api.Path.Snippet(token: params.token, keySearch: params.keySearch, keyID: params.keyID)
        return api.request(method: .get, urlString: path) { (result) in
            Mapper<Snippet>().map(result: result, type: .object, completion: { (result) in
                DispatchQueue.main.async {
                    completion(result)
                }
            })
        }
    }
}
