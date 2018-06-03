//
//  CategoryController.swift
//  HalfPrice
//
//  Created by QueenaHuang on 7/5/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit
import XLPagerTabStrip

private let reuseIdentifier = "ProduceCell"

class CategoryController: UICollectionViewController, UICollectionViewDelegateFlowLayout, IndicatorInfoProvider {

    lazy var viewModel: CategoryViewModel = {
        return CategoryViewModel()
    }()

    var tagIndex = 0
    var activityIndicator:UIActivityIndicatorView!

    var itemInfo = IndicatorInfo(title: "View")

    init(layout: UICollectionViewLayout, index: Int, itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        self.tagIndex = index
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "ProduceCell", bundle: Bundle.main)
        collectionView?.register(nib, forCellWithReuseIdentifier: reuseIdentifier)

        self.collectionView?.backgroundColor = UIColor.white

        setupLoading()

        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }

        }

        viewModel.reloadViewClosure = { [weak self] in
            self?.collectionView?.reloadData()
        }

        if let title = itemInfo.title {
            viewModel.currentCategory = title
        }

        viewModel.initFetch(tagIndex: tagIndex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let frame = collectionView.safeAreaLayoutGuide.layoutFrame
        return CGSize(width: frame.size.width, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ProductCell else {
            fatalError("Dequeueing ProductCell failed")
        }

        let product = viewModel.getCellViewModel(at: indexPath)
        cell.product = product
        return cell
    }

    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

    private func setupLoading() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:
            UIActivityIndicatorViewStyle.gray)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
}
