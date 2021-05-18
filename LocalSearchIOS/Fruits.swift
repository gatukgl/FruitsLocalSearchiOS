//
//  Fruits.swift
//  LocalSearchIOS
//
//  Created by Gatuk Chattanon on 18/5/21.
//

import Foundation
import RealmSwift

// MARK: - Schema
class Fruits: Object {
    @objc dynamic var id = 0
    @objc dynamic var productCode = ""
    @objc dynamic var name = ""
    @objc dynamic var image = ""
    @objc dynamic var searchString = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(id: Int = 0,
                  productCode: String = "",
                  name: String = "",
                  image: String = "") {
        self.init()
        self.id = id
        self.productCode = productCode
        self.name = name
        self.image = image
        self.searchString = "\(id) \(productCode) \(productCode) \(name) \(image)"
    }
}

// MARK: - Realm

class FruitsStore {
    var dbManager: DbManagerProtocol

    init(dbManager: DbManagerProtocol) {
        self.dbManager = dbManager
        save()
    }

    func getAll() -> [Fruits] {
        let fruits: [Fruits] = dbManager.getAll()
        return fruits
    }

    func search(text: String) -> [Fruits] {
        let filteredFruits: [Fruits] = dbManager.filter(searchString: text)
        return filteredFruits
    }

    private func save() {
        let fruits = _generateFruitsChunk()
        dbManager.save(fruits)
    }

    private func deleteAllContents() {
        let _: [Fruits] = dbManager.deleteAll()
    }

    private func _generateFruitsChunk() -> [Fruits] {
        var fruits: [Fruits] = []

        for i in 1...1000 {
            fruits.append(
                Fruits(
                    id: i,
                    productCode: "\(i)",
                    name: "Fruit No. \(i)",
                    image: "Image\(i).png"
                )
            )
        }

        return fruits
    }
}
