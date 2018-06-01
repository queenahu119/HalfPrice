//
//  DataHelper.swift
//  HalfPrice
//
//  Created by QueenaHuang on 15/4/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation
import FirebaseDatabase
import RealmSwift

class DataHelper: NSObject {

    fileprivate var reference: DatabaseReference!
    fileprivate var products: [Product] = []
    fileprivate var categorys: [String] = []
    fileprivate var _refHandle: DatabaseHandle?

    let realmManager = RealmManager()

    func fetchDataByCategory(_ category: String, completion: @escaping (_ collection: [Product]?) -> Void) {
        reference = Database.database().reference()

        _refHandle = self.reference.observe(.childAdded, with: { (snapshot) in
            guard let value = snapshot.value as? [String: AnyObject] else {
                print("Firebase's data have wrong format.")
                return
            }

            var collection: [Product] = []
            let key = category.lowercased()
            let categoryPath = value["key_in_category_list"] as? String ?? ""

            if (categoryPath.contains(key)) {
                let product = Product()
                product.configure(jsonDictionary: value)
                collection.append(product)

                self.realmManager.saveObjects(objs: product)
            }

            completion(collection)
        })
    }

    func fetchDataToRealm(completion: @escaping () -> Void) {
        reference = Database.database().reference()

        _refHandle = self.reference.observe(.childAdded, with: { (snapshot) in
            guard let value = snapshot.value as? [String: AnyObject] else {
                print("Firebase's data have wrong format.")
                return
            }

            let product = Product()
            product.configure(jsonDictionary: value)

            guard let id = product.id else {
                return
            }

            let predicate = NSPredicate(format: "id = %@", id)
            guard let products = self.realmManager.getProductObjects(predicate) else {
                return
            }

            if (products.isEmpty) {
                self.realmManager.saveObjects(objs: product)
            }

            completion()
        })
    }
}
