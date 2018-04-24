//
//  Product.swift
//  HalfPrice
//
//  Created by QueenaHuang on 11/4/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation

struct Product {
    var brand:String?
    var category:String?
    var id:String?
    var isValid:Bool?
    var keyword:String?
    var keyInCategoryList:String?
    var likes:Int
    var locationNsw:Bool?
    var locationNt:Bool?
    var locationQld:Bool?
    var locationSa:Bool?
    var locationTas:Bool?
    var locationVic:Bool?
    var locationWa:Bool?
    var name:String?
    var packagePrice:String?
    var packageSize:String?
    var price:Float
    var source:String?
    var sourceShort:String?
    var stockCode:String?
    var thumbnailUrl:String?
    var wasPrice:Float

    init(jsonDictionary: [String: AnyObject]) {
        let value = jsonDictionary

        self.brand = value["brand"] as? String
        self.category = value["category"] as? String
        self.id = value["id"] as? String
        self.isValid = value["is_valid"] as? Bool
        self.keyword = value["key"] as? String
        self.keyInCategoryList = value["key_in_category_list"] as? String
        self.likes = Int(truncating: (value["likes"] as? NSNumber) ?? 0)
        self.locationNsw = value["location_nsw"] as? Bool
        self.locationNt = value["location_nt"] as? Bool
        self.locationQld = value["location_qld"] as? Bool
        self.locationSa = value["location_sa"] as? Bool
        self.locationTas = value["location_tas"] as? Bool
        self.locationVic = value["location_vic"] as? Bool
        self.locationWa = value["location_wa"] as? Bool
        self.name = value["name"] as? String
        self.packagePrice = value["package_price"] as? String
        self.packageSize = value["package_size"] as? String
        self.price = (value["price"] as? NSNumber)?.floatValue ?? 0
        self.source = value["source"] as? String
        self.sourceShort = value["source_short"] as? String
        self.stockCode = value["stock_code"] as? String
        self.thumbnailUrl = value["thumbnail_url"] as? String
        self.wasPrice = (value["was_price"] as? NSNumber)?.floatValue ?? 0

    }

}
