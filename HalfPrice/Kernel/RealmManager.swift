//
//  RealmManager.swift
//  HalfPrice
//
//  Created by QueenaHuang on 1/6/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    let realm = globalRealm

    static var globalRealm: Realm? {
        var realm: Realm? = nil

        do {
            realm = try Realm()
        } catch let error as NSError {
            print("Init Failed: ", error)
        }
        return realm
    }

    func deleteDatabase() {
        try? realm?.write({
            realm?.deleteAll()
        })
    }

    func deleteObject(objs : Object) {
        try? realm?.write ({
            realm?.delete(objs)
        })
    }

    func addObjects(objs: Object) {
        try? realm?.write ({
            // If update = false, adds the object
            realm?.add(objs, update: false)
        })
    }

    func saveObjects(objs: Object) {
        try? realm?.write ({
            // If update = true, it can update the exist object by primaryKey,
            // Or add the new one.
            realm?.add(objs, update: true)
        })
    }

    func editObjects(objs: Object) {
        try? realm!.write ({
            realm?.add(objs, update: true)
        })
    }

    func getObjects() -> [Product]? {
        guard let objects = realm?.objects(Product.self).toArray(ofType: Product.self) else {
            return nil
        }
        return objects.isEmpty ? nil : objects
    }

    func getProductObjects(category: String, source: String?) -> [Product]? {
        var predicate = NSPredicate(format: "keyInCategoryList CONTAINS %@", category.lowercased())

        if let source = source {
            predicate = NSPredicate(format: "source = %@ && keyInCategoryList CONTAINS %@", source, category.lowercased())
        }

        guard let objects = realm?.objects(Product.self).filter(predicate).toArray(ofType: Product.self) else {
            return nil
        }
        return objects.isEmpty ? nil : objects
    }

    func getProductObjects(_ predicate: NSPredicate) -> [Product]? {
        guard let objects = realm?.objects(Product.self).filter(predicate).toArray(ofType: Product.self) else {
            return nil
        }
        return objects.isEmpty ? nil : objects
    }

    func isEmpty() -> Bool {
        guard let realm = realm else {
            return true
        }

        let results = realm.objects(Product.self)

        if (results.isEmpty) {
            return true
        } else {
            return false
        }
    }

    func isUpdateToDate() -> Bool {
        return false
    }

    // MARK: - Category Object
    func getCategoryObjects() -> Results<Category>? {
        return realm?.objects(Category.self)
    }
}
