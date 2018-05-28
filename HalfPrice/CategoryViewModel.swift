//
//  HomeViewModel.swift
//  HalfPrice
//
//  Created by QueenaHuang on 11/5/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation

class CategoryViewModel: NSObject {

    let dataHelper : DataHelper

    init(dataHelper: DataHelper = DataHelper()) {
        self.dataHelper = dataHelper
    }

    var currentCategory: String?

    // MARK: - callback
    var reloadViewClosure: (() -> Void)?

    private var cellViewModels: [String: [ProductCellViewModel]] = [String: [ProductCellViewModel]]() {
        didSet {
            self.reloadViewClosure?()
        }
    }

    var numberOfCells: Int {
        if let currentCategory = currentCategory, let result = cellViewModels[currentCategory] {
            return result.count
        }
        return 0
    }

    func getCellViewModel( at indexPath: IndexPath) -> ProductCellViewModel? {
        guard let currentCategory = currentCategory,
            let items = cellViewModels[currentCategory] else {
            return nil
        }

        return items[indexPath.row]
    }

    func initFetch(tagNames: [CategoryName]) {
        fetchAllProducts(tagNames)
    }

    func initFetch() {

        guard let currentCategory = currentCategory else {
            return
        }

        fetchProducts(currentCategory)
    }

    fileprivate func fetchProducts(_ name: String) {
        let category = name

        self.dataHelper.fetchDataByCategory(category) { [weak self] (products) in
            guard let products = products else {
                return
            }

            if self?.cellViewModels[category] == nil {
                self?.cellViewModels[category] = [ProductCellViewModel]()
            }

            for product in products {

                let description = "\(product.packageSize!) \(product.packagePrice!)"

                let cell = ProductCellViewModel(titleText: product.name,
                                                brandText:product.brand ,
                                                descText: description,
                                                imageUrl: product.thumbnailUrl,
                                                price: product.price,
                                                pastPrice:product.wasPrice,
                                                isLike:false)
                self?.cellViewModels[category]?.append(cell)

            }
        }
    }

    fileprivate func fetchAllProducts(_ tagNames: [CategoryName]) {

        for item in tagNames {
            let category = item.rawValue

            self.dataHelper.fetchDataByCategory(category) { [weak self] (products) in
                guard let products = products else {
                    return
                }

                if self?.cellViewModels[category] == nil {
                    self?.cellViewModels[category] = [ProductCellViewModel]()
                }

                for product in products {

                    let description = "\(product.packageSize!) \(product.packagePrice!)"

                    let cell = ProductCellViewModel(titleText: product.name,
                                                    brandText:product.brand ,
                                                    descText: description,
                                                    imageUrl: product.thumbnailUrl,
                                                    price: product.price,
                                                    pastPrice:product.wasPrice,
                                                    isLike:false)
                    self?.cellViewModels[category]?.append(cell)
                }
            }
        }
    }
}

struct ProductCellViewModel {
    let titleText: String?
    let brandText: String?

    let descText: String?
    let imageUrl: String?
    let price: Float?
    let pastPrice: Float?
    let isLike: Bool?
}
