//
//  ViewController.swift
//  HalfPrice
//
//  Created by QueenaHuang on 17/4/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!

    lazy var viewModel: TableViewModel = {
        return TableViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Product"
        navigationController?.navigationBar.isTranslucent = false

        navigationController?.navigationBar.barTintColor = UIColor.blue

        // get rid of black bar underneath navBar
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        viewModel.reloadTableViewClosure = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.initFetch()

        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)

        setupMenuBar()
        setupNavBarButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()

    private func setupMenuBar() {
        view.addSubview(menuBar)

        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.height.equalTo(50)
        }

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { (make)  in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }

    private func setupNavBarButtons() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onSearch))
        let bookmarksButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(onSearch))
        navigationItem.rightBarButtonItems = [searchButton, bookmarksButton]

    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProductCellId", for: indexPath) as! ProductCell

        let product = viewModel.getCellViewModel(at: indexPath)

        cell.product = product

        return cell
    }

    // MARK: - Action
    @objc func onSearch() {

    }

}
