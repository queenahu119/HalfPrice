//
//  ExtensionRealm.swift
//  HalfPrice
//
//  Created by QueenaHuang on 3/6/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        let array = Array(self) as! [T]
        return array
    }
}
