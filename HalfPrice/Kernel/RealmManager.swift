//
//  RealmManager.swift
//  HalfPrice
//
//  Created by QueenaHuang on 1/6/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation
import  RealmSwift

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

    func saveObjects(objs: Object) {
        try? realm?.write ({
            // If update = false, adds the object
            realm?.add(objs, update: false)
        })
    }

    func editObjects(objs: Object) {
        try? realm!.write ({
            realm?.add(objs, update: true)
        })
    }

    // Returs an array as Results<object>?
    func getObjects(type: Product.Type) -> Results<Product>? {
        return realm?.objects(type)
    }

    func getProductObjects(category: String?) -> Results<Product>? {
        let predicate = NSPredicate(format: "category = %@", category ?? "")
        let products = realm?.objects(Product.self).filter(predicate)
        return products
    }

    func getProductObjects(_ predicate: NSPredicate) -> Results<Product>? {
        let products = realm?.objects(Product.self).filter(predicate)
        return products
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
}
