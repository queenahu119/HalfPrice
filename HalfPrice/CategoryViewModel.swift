//
//  HomeViewModel.swift
//  HalfPrice
//
//  Created by QueenaHuang on 11/5/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryViewModel: NSObject {

    let dataHelper : DataHelper
    let realmManager = RealmManager()

    init(dataHelper: DataHelper = DataHelper()) {
        self.dataHelper = dataHelper
    }

    var currentCategory: String?

    // MARK: - callback
    var reloadViewClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    
    private var cellViewModels: [ProductCellViewModel] = [ProductCellViewModel]() {
        didSet {
            self.reloadViewClosure?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    var numberOfCells: Int {
        if currentCategory != nil {
            return cellViewModels.count
        }
        return 0
    }

    func getCellViewModel( at indexPath: IndexPath) -> ProductCellViewModel? {
        guard currentCategory != nil else {
            return nil
        }

        return cellViewModels[indexPath.row]
    }

    func initFetch(tagIndex: Int) {
        guard let currentCategory = currentCategory else {
            return
        }

        self.cellViewModels = [ProductCellViewModel]()

        if !realmManager.isUpdateToDate() {
            if (tagIndex == 0) {
                fetchProducts(currentCategory)
            } else {
                self.addProductsToViewModel(category: currentCategory)
            }

        }
    }

    fileprivate func fetchProducts(_ category: String) {
        self.isLoading = true
        self.dataHelper.fetchDataToRealm { [weak self] () in
            self?.isLoading = false
            self?.addProductsToViewModel(category: category)
        }
    }

    func addProductsToViewModel(category: String) {

        guard let products = realmManager.getProductObjects(category: category) else {
            return
        }

        for product in products {
            let description = "\(product.packageSize!) \(product.packagePrice!)"

            let cell = ProductCellViewModel(titleText: product.name,
                                            brandText:product.brand ,
                                            descText: description,
                                            imageUrl: product.thumbnailUrl,
                                            price: product.price,
                                            pastPrice:product.wasPrice.value,
                                            isLike:false)
            self.cellViewModels.append(cell)
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
