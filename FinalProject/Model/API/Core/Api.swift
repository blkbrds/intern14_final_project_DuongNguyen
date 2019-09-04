//
//  App.swift
//  FinalProject
//
//  Created by Bien Le Q. on 8/26/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import Alamofire

final class Api {

    struct Path {
        static let baseURL = "https://www.googleapis.com/youtube"
    }

    struct Snippet {}
}

extension Api.Path {
    struct Snippet: ApiPath {
        static var path: String { return baseURL / "v3/search?" }
        let token: String
        let keySearch: String
        let keyID: String
        var urlString: String { return Snippet.path / "pageToken=\(token)&part=snippet&maxResults=10&order=relevance&q=\(keySearch)&key=\(keyID)" }
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

private func / (left: String, right: Int) -> String {
    return left.appending(path: "\(right)")
}
