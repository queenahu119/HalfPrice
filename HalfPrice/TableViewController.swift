//
//  TableViewController.swift
//  HalfPrice
//
//  Created by QueenaHuang on 8/4/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit
import Firebase
import SnapKit

class TableViewController: UITableViewController {

    lazy var viewModel: TableViewModel = {
        return TableViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Half Price"
        navigationController?.navigationBar.isTranslucent = false

        edgesForExtendedLayout = []

        viewModel.reloadTableViewClosure = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.initFetch()

        setupMenuBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    let menuBar: MenuBar = {
        let menuBar = MenuBar()
        return menuBar
    }()

    private func setupMenuBar() {
//        view.addSubview(menuBar)
        view.bringSubview(toFront: menuBar)

        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.snp.makeConstraints { (make) in
//            make.left.equalTo(view.snp.left)
//            make.right.equalTo(view.snp.right)
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(50)
        }

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

//        cell.labelDescription.text = product.descText
//        cell.productImageView.imageFromServerURL(url: product.imageUrl)
//
//        let attribute = [ NSAttributedStringKey.foregroundColor: UIColor.red , NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28)]
//        let price = product.price.format(".2")
//        let attrString = NSMutableAttributedString(string: "$\(price) ", attributes: attribute)
//
//        if let wasPrice = product.pastPrice {
//            let wasPriceString = wasPrice.format(".2")
//            let attrPastPriceString = NSAttributedString(string: "was $\(wasPriceString)")
//            attrString.append(attrPastPriceString)
//        }
//
//        cell.labelPrice.attributedText = attrString

        return cell
    }

}
