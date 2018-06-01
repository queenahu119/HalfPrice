//
//  Supermarket.swift
//  HalfPrice
//
//  Created by QueenaHuang on 29/5/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

enum Location: String {
    case nsw = "NSW"
    case nt = "Nt"
    case qld = "Qld"
    case sa = "Sa"
    case tas = "Tas"
    case vic = "Vic"
    case wa = "Wa"
}

class Product: Object {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var brand: String?
    @objc dynamic var category: String?
    var isValid = RealmOptional<Bool>()
    @objc dynamic var keyword: String?
    @objc dynamic var keyInCategoryList: String?
    var likes = RealmOptional<Int>()
    @objc dynamic var location: String?

    @objc dynamic var packagePrice: String?
    @objc dynamic var packageSize: String?
    @objc dynamic var price: Float = 0.0
    @objc dynamic var source: String?
    @objc dynamic var sourceShort: String?
    @objc dynamic var stockCode: String?
    @objc dynamic var thumbnailUrl: String?
    var wasPrice = RealmOptional<Float>()

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Product {

    func configure(jsonDictionary: [String: AnyObject]) {
        let value = jsonDictionary

        self.brand = value["brand"] as? String
        self.category = value["category"] as? String
        self.id = value["id"] as? String
        self.isValid.value = value["is_valid"] as? Bool
        self.keyword = value["key"] as? String
        self.keyInCategoryList = value["key_in_category_list"] as? String
        self.likes.value = Int(truncating: (value["likes"] as? NSNumber) ?? 0)

        self.name = value["name"] as? String
        self.packagePrice = value["package_price"] as? String
        self.packageSize = value["package_size"] as? String
        self.price = (value["price"] as? NSNumber)?.floatValue ?? 0
        self.source = value["source"] as? String
        self.sourceShort = value["source_short"] as? String
        self.stockCode = value["stock_code"] as? String
        self.thumbnailUrl = value["thumbnail_url"] as? String
        self.wasPrice.value = (value["was_price"] as? NSNumber)?.floatValue

        if (value["location_nsw"] as? Bool) != nil {
            self.location = Location.nsw.rawValue
        } else if (value["location_nt"] as? Bool) != nil {
            self.location = Location.nt.rawValue
        } else if (value["location_qld"] as? Bool) != nil {
            self.location = Location.qld.rawValue
        } else if (value["location_sa"] as? Bool) != nil {
            self.location = Location.sa.rawValue
        } else if (value["location_tas"] as? Bool) != nil {
            self.location = Location.tas.rawValue
        } else if (value["location_vic"] as? Bool) != nil {
            self.location = Location.vic.rawValue
        } else if (value["location_wa"] as? Bool) != nil {
            self.location = Location.wa.rawValue
        }
    }
}
