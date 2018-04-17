//
//  TableViewController.swift
//  HalfPrice
//
//  Created by QueenaHuang on 8/4/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {

    lazy var viewModel: TableViewModel = {
        return TableViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.reloadTableViewClosure = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.initFetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.numberOfCells
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue cell
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProductCellId", for: indexPath) as! ProductCell

        let product = viewModel.getCellViewModel(at: indexPath)

        cell.labelName.text = product.titleText
        cell.labelBrand.text = product.brandText

        cell.labelDescription.text = product.descText
        cell.productImageView.imageFromServerURL(url: product.imageUrl)

        let attribute = [ NSAttributedStringKey.foregroundColor: UIColor.red , NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28)]
        let price = product.price.format(".2")
        let attrString = NSMutableAttributedString(string: "$\(price) ", attributes: attribute)

        if let wasPrice = product.pastPrice {
            let wasPriceString = wasPrice.format(".2")
            let attrPastPriceString = NSAttributedString(string: "was $\(wasPriceString)")
            attrString.append(attrPastPriceString)
        }

        cell.labelPrice.attributedText = attrString

        return cell
    }


}
