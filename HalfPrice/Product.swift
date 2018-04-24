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

        let name = value["name"] as? String
        let brand = value["brand"] as? String
        let category = value["category"] as? String
        let id = value["id"] as? String
        let isValid = value["is_valid"] as? Bool
        let keyword = value["key"] as? String
        let keyInCategoryList = value["key_in_category_list"] as? String
        let likes = value["likes"] as? NSNumber
        let locationNsw = value["location_nsw"] as? Bool
        let locationNt = value["location_nt"] as? Bool
        let locationQld = value["location_qld"] as? Bool
        let locationSa = value["location_sa"] as? Bool
        let locationTas = value["location_tas"] as? Bool
        let locationVic = value["location_vic"] as? Bool
        let locationWa = value["location_wa"] as? Bool
        let packagePrice = value["package_price"] as? String
        let packageSize = value["package_size"] as? String
        let price = value["price"] as? NSNumber
        let source = value["source"] as? String
        let sourceShort = value["source_short"] as? String
        let stockCode = value["stock_code"] as? String
        let thumbnailUrl = value["thumbnail_url"] as? String
        let wasPrice = value["was_price"] as? NSNumber

        self.brand = brand
        self.category = category
        self.id = id
        self.isValid = isValid
        self.keyword = keyword
        self.keyInCategoryList = keyInCategoryList
        self.likes = Int(truncating: likes ?? 0)
        self.locationNsw = locationNsw
        self.locationNt = locationNt
        self.locationQld = locationQld
        self.locationSa = locationSa
        self.locationTas = locationTas
        self.locationVic = locationVic
        self.locationWa = locationWa
        self.name = name
        self.packagePrice = packagePrice
        self.packageSize = packageSize
        self.price = price?.floatValue ?? 0
        self.source = source
        self.sourceShort = sourceShort
        self.stockCode = stockCode
        self.thumbnailUrl = thumbnailUrl
        self.wasPrice = wasPrice?.floatValue ?? 0

    }

}
