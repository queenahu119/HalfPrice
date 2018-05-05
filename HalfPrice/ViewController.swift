//
//  ViewController.swift
//  HalfPrice
//
//  Created by QueenaHuang on 17/4/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"

    lazy var viewModel: TableViewModel = {
        return TableViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Product"
        navigationController?.navigationBar.isTranslucent = false

        // get rid of black bar underneath navBar
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        viewModel.reloadTableViewClosure = { [weak self] in

        }

        viewModel.initFetch()

        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.homeController = self
        return menuBar
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    private func setupMenuBar() {

        navigationController?.hidesBarsOnSwipe = true
        view.addSubview(menuBar)

        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.height.equalTo(50)
        }

    }

    private func setupNavBarButtons() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search,
                                           target: self, action: #selector(onSearch))
        let bookmarksButton = UIBarButtonItem(barButtonSystemItem: .bookmarks,
                                              target: self, action: #selector(onSearch))
        navigationItem.rightBarButtonItems = [searchButton, bookmarksButton]

    }

    private func setupCollectionView() {
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        collectionView.delegate = self
        collectionView.dataSource = self

//        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
//        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)

        collectionView.backgroundColor = UIColor.white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)

        collectionView.isPagingEnabled = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuBar.tagNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)

        for view in cell.subviews {
            view.removeFromSuperview()
        }

        let label = UILabel(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        label.text = String(indexPath.row)
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        cell.addSubview(label)

        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let frame = collectionView.safeAreaLayoutGuide.layoutFrame
        return CGSize(width: frame.size.width, height: frame.size.height)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let index = floor(scrollView.contentOffset.x / CGFloat(collectionView.frame.width))

        menuBar.menuIndex = Int(index)

        let newFrame = cellWidth * CGFloat(index) - menuBar.collectionView.contentOffset.x
        menuBar.horizontalBarLeftAnchorConstraint?.update(offset: newFrame)

//        UIView.animate(withDuration: 0.75) {
//            self.menuBar.layoutIfNeeded()
//        }

        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }

    func scrollToMenuIndex(menuIndex: Int) {
        
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }


    // MARK: - Table view data source

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return viewModel.numberOfCells
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 180
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProductCellId",
//                                                            for: indexPath) as? ProductCell else {
//            fatalError("Dequeueing tableviewCell failed")
//        }
//
//        let product = viewModel.getCellViewModel(at: indexPath)
//
//        cell.product = product
//
//        return cell
//    }

    // MARK: - Action
    @objc func onSearch() {
        scrollToMenuIndex(menuIndex: 2)
    }

}
