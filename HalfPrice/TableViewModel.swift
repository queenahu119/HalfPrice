//
//  TableViewModel.swift
//  HalfPrice
//
//  Created by QueenaHuang on 15/4/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation
import FirebaseDatabase

class TableViewModel: NSObject {

    let dataHelper : DataHelper

    init(dataHelper: DataHelper = DataHelper()) {
        self.dataHelper = dataHelper
    }

    //MARK: - callback
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?

    var ref: DatabaseReference!
    var messages: [Product] = []
    fileprivate var _refHandle: DatabaseHandle?
    
    private var cellViewModels: [ProductCellViewModel] = [ProductCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var numberOfCells: Int {
        return cellViewModels.count
    }

    func getCellViewModel( at indexPath: IndexPath ) -> ProductCellViewModel {

        return cellViewModels[indexPath.row]
    }

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    func initFetch() {
        configureDatabase()
    }

    func configureDatabase() {
        ref = Database.database().reference()

        _refHandle = self.ref.observe(.childAdded, with: { [weak self] (snapshot) in
            guard let strongSelf = self else { return }
            guard let value = snapshot.value as? [String: AnyObject] else {
                print("Firebase's data have wrong format.")
                return
            }

            let product = Product(jsonDictionary: value)

            strongSelf.messages.append(product)

            let description = "\(product.package_size!) \(product.package_price!)"


            let cell = ProductCellViewModel(titleText: product.name!, brandText:product.brand! , descText: description, imageUrl: product.thumbnail_url!, price: product.price, pastPrice:product.was_price, isLike:false)

            strongSelf.cellViewModels.append(cell)

        })

    }

}

struct ProductCellViewModel {
    let titleText: String
    let brandText: String

    let descText: String
    let imageUrl: String
    let price: Float
    let pastPrice: Float?
    let isLike: Bool

}
