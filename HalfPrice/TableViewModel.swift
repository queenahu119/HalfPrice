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

    // MARK: - callback
    var reloadTableViewClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?

    var reference: DatabaseReference!
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
        reference = Database.database().reference()

        _refHandle = self.reference.observe(.childAdded, with: { [weak self] (snapshot) in
            guard let strongSelf = self else { return }
            guard let value = snapshot.value as? [String: AnyObject] else {
                print("Firebase's data have wrong format.")
                return
            }

            let product = Product(jsonDictionary: value)

            strongSelf.messages.append(product)

            let description = "\(product.packageSize!) \(product.packagePrice!)"

            let cell = ProductCellViewModel(titleText: product.name,
                                            brandText:product.brand ,
                                            descText: description,
                                            imageUrl: product.thumbnailUrl,
                                            price: product.price,
                                            pastPrice:product.wasPrice,
                                            isLike:false)

            strongSelf.cellViewModels.append(cell)

        })

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
