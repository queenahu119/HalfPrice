//
//  Product.swift
//  HalfPrice
//
//  Created by QueenaHuang on 11/4/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation

struct Product: Codable {
    let brand:String?
    let category:String?
    let id:String?
    let is_valid:Bool?
    let key:String?
    let key_in_category_list:String?
    let likes:Int
    let location_nsw:Bool?
    let location_nt:Bool?
    let location_qld:Bool?
    let location_sa:Bool?
    let location_tas:Bool?
    let location_vic:Bool?
    let location_wa:Bool?
    let name:String?
    let package_price:String?
    let package_size:String?
    let price:Float
    let source:String?
    let source_short:String?
    let stock_code:String?
    let thumbnail_url:String?
    let was_price:Float

    init(jsonDictionary: [String: AnyObject])
    {
        let value = jsonDictionary

        let name = value["name"] as? String
        let brand = value["brand"] as? String
        let category = value["category"] as? String
        let id = value["id"] as? String
        let is_valid = value["is_valid"] as? Bool
        let key = value["key"] as? String
        let key_in_category_list = value["key_in_category_list"] as? String
        let likes = value["likes"] as? NSNumber
        let location_nsw = value["location_nsw"] as? Bool
        let location_nt = value["location_nt"] as? Bool
        let location_qld = value["location_qld"] as? Bool
        let location_sa = value["location_sa"] as? Bool
        let location_tas = value["location_tas"] as? Bool
        let location_vic = value["location_vic"] as? Bool
        let location_wa = value["location_wa"] as? Bool
        let package_price = value["package_price"] as? String
        let package_size = value["package_size"] as? String
        let price = value["price"] as? NSNumber
        let source = value["source"] as? String
        let source_short = value["source_short"] as? String
        let stock_code = value["stock_code"] as? String
        let thumbnail_url = value["thumbnail_url"] as? String
        let was_price = value["was_price"] as? NSNumber

        self.brand = brand
        self.category = category
        self.id = id
        self.is_valid = is_valid
        self.key = key
        self.key_in_category_list = key_in_category_list
        self.likes = Int(truncating: likes ?? 0)
        self.location_nsw = location_nsw
        self.location_nt = location_nt
        self.location_qld = location_qld
        self.location_sa = location_sa
        self.location_tas = location_tas
        self.location_vic = location_vic
        self.location_wa = location_wa
        self.name = name
        self.package_price = package_price
        self.package_size = package_size
        self.price = price?.floatValue ?? 0
        self.source = source
        self.source_short = source_short
        self.stock_code = stock_code
        self.thumbnail_url = thumbnail_url
        self.was_price = was_price?.floatValue ?? 0

    }
}
