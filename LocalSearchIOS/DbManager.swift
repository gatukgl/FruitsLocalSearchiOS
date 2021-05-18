//
//  DbManager.swift
//  OneApp
//
//  Created by Gatuk Chattanon on 18/2/21.
//  Copyright © 2021 TMB. All rights reserved.
//
//  To get Realm file location on simulator. While debugging and paused, run command ...
//
//          po Realm.Configuration.defaultConfiguration.fileURL
//

import RealmSwift

protocol DbManagerProtocol {
    func getObject<T>(forKey key: String) -> T? where T: Object
    func getAll<T>() -> [T] where T: Object
    func save<T>(_ objects: [T]) where T: Object
    func deleteAll<T>() -> [T] where T: Object
}

class DbManager: DbManagerProtocol {
    static let shared = DbManager()

    private init() {}

    var realm: Realm? {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            return try Realm()
        } catch let error {
            print("[Realm Error] configs", error)
            return nil
        }
    }

    func getObject<T>(forKey key: String) -> T? where T: Object {
        print("[Info] RealmDB URL", realm?.configuration.fileURL ?? "-")
        return realm?.object(ofType: T.self, forPrimaryKey: key)
    }

    func getAll<T>() -> [T] where T: Object {
        print("[Info] RealmDB URL", realm?.configuration.fileURL ?? "-")
        return realm?.objects(T.self).map { $0 } ?? []
    }

    func save<T>(_ objects: [T]) where T: Object {
        print("[Info] RealmDB URL", realm?.configuration.fileURL ?? "-")
        do {
            try self.realm?.write {
                realm?.add(objects, update: .all)
            }
        } catch let error {
            print("[Realm Error] add: ", error)
        }
    }

    func deleteAll<T>() -> [T] where T: Object {
        let allItems: [T] = self.getAll()
        do {
            try self.realm?.write {
                realm?.delete(allItems)
            }
        } catch let error {
            print("[Realm Error] delete: ", error)
        }
        return allItems
    }
}
