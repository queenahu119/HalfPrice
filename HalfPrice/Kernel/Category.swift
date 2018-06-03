//
//  Category.swift
//  HalfPrice
//
//  Created by QueenaHuang on 3/6/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Category: Object {
    @objc dynamic var name: String?

    override static func primaryKey() -> String? {
        return "name"
    }
}
