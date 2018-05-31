//
//  UIViewController.swift
//  HalfPrice
//
//  Created by QueenaHuang on 30/5/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit

extension UIViewController {

    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
    }

    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
    }
}
