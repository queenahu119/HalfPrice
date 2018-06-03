//
//  LoadingViewController.swift
//  HalfPrice
//
//  Created by QueenaHuang on 3/6/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit

@objc public protocol WelcomeViewControllerDelegate {
    @objc optional func loadingViewCompletion()
}

class WelcomeViewController: UIViewController {

    open weak var delegate: WelcomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blue

        let realmMigration = RealmMigration()
        realmMigration.didApplicationLunch()

        // test:
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.delegate?.loadingViewCompletion?()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
