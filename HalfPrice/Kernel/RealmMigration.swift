//
//  RealmMigration.swift
//  HalfPrice
//
//  Created by QueenaHuang on 1/6/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMigration {

    func didApplicationLunch () {
        self.migrationVersion()

        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    func migrationVersion() {
        let config = Realm.Configuration(
            schemaVersion : 0,
            migrationBlock : { migration , oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
    }
}
