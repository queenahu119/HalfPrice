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
import SlideMenuControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let realmMigration = RealmMigration()
    var window: UIWindow?

    fileprivate func createMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let mainViewController = storyboard.instantiateViewController(withIdentifier: "HomeController") as! HomeController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController

        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.mainViewController = nvc

        UINavigationBar.appearance().tintColor = Color.themeBackground

        let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController)
        slideMenuController.delegate = mainViewController

        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        realmMigration.didApplicationLunch()

        // Test: Add new value to database
        let realmManager = RealmManager()
        realmManager.deleteDatabase()

        createMenuView()
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
