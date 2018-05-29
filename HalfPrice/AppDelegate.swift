//
//  AppDelegate.swift
//  HalfPrice
//
//  Created by QueenaHuang on 30/3/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

var uiRealm: Realm?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        do {
            uiRealm = try Realm()
        } catch let error as NSError {
            print("Init Failed: ", error)
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

}
