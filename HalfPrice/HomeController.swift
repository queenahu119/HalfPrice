//
//  HomeController.swift
//  HalfPrice
//
//  Created by QueenaHuang on 7/5/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SlideMenuControllerSwift

enum CategoryName: String {
    case hot = "Hot"
    case frozen = "Frozen"
    case drinks = "Drinks"
    case household = "Household"
    case beauty = "Beauty"
    case living = "Living"
    case international = "International"
    case dairy = "Dairy"
    case bakery = "Bakery"
    case meat = "Meat"
    case stationery = "Stationery"
    case pet = "Pet"
    case alcohol = "Alcohol"
    case pantry = "Pantry"
}

class HomeController: ButtonBarPagerTabStripViewController {

    var tagNames: [CategoryName] = [.pantry, .frozen, .drinks, .household, .pet]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Product"
        navigationController?.navigationBar.isTranslucent = false

        // get rid of black bar underneath navBar
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        buttonBarView.selectedBar.backgroundColor = .orange
        buttonBarView.backgroundColor = Color.themeBackground
        
        setupNavBarButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }

    private func setupNavBarButtons() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search,
                                           target: self, action: #selector(onSearch))
        let bookmarksButton = UIBarButtonItem(barButtonSystemItem: .bookmarks,
                                              target: self, action: #selector(onSearch))
        navigationItem.rightBarButtonItems = [searchButton, bookmarksButton]

    }

    // MARK: - PagerTabStripDataSource

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {

        let layout = UICollectionViewFlowLayout()
        var childViewControllers: [CategoryController]? = []

        for (index, item) in tagNames.enumerated() {
            let title = IndicatorInfo(title: item.rawValue)
            let child = CategoryController(layout: layout, index: index, itemInfo: title)
            childViewControllers?.append(child)
        }

        return childViewControllers ?? []
    }

    // MARK: - Action
    @objc func onSearch() {

    }
}

extension HomeController : SlideMenuControllerDelegate {

    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
}
