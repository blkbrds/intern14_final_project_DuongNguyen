//
//  RealmManager.swift
//  FinalProject
//
//  Created by MBA0065 on 9/16/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmManager {
  static let shared = RealmManager()
  private init() { }
  private let realm: Realm? = {
    do {
      return try Realm()
    } catch {
      return nil
    }
  }()
}

extension RealmManager {
  private func write(_ closure: () -> Void, completion: Completion? = nil) {
    realm?.beginWrite()
    closure()
    do {
      try realm?.commitWrite()
      completion?(.success)
    } catch {
      realm?.cancelWrite()
      completion?(.failure(error))
    }
  }

  func fetchObjects<T: Object>(_ type: T.Type, filter predicate: NSPredicate? = nil) -> Results<T>? {
    guard let predicate = predicate else {
      return realm?.objects(type)
    }
    return realm?.objects(type).filter(predicate)
  }

  func fetchObject<T: Object>(_ type: T.Type, filter predicate: NSPredicate? = nil) -> T? {
    let results = fetchObjects(type, filter: predicate)
    return results?.first
  }

  func add<T: Object>(object: T, completion: Completion? = nil) {
    write({
      realm?.add(object, update: .modified)
    }, completion: completion)
  }

  func add<T: Object>(objects: [T], completion: Completion? = nil) {
    write({
      realm?.add(objects, update: .modified)
    }, completion: completion)
  }

  func delete<T: Object>(object: T, completion: Completion? = nil) {
    write({
      realm?.delete(object)
    }, completion: completion)
  }

  func deleteAll<T: Object>(objects: [T], completion: Completion? = nil) {
    write({
      realm?.delete(objects)
    }, completion: completion)
  }
}

extension RealmManager {
  typealias Completion = (RealmResult) -> Void
  enum RealmResult {
    case success
    case failure(Error)
  }
}
