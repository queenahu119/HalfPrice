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

    lazy var viewModel: TableViewModel = {
        return TableViewModel()
    }()

    var itemInfo = IndicatorInfo(title: "View")

    init(layout: UICollectionViewLayout, itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "ProduceCell", bundle: Bundle.main)
        collectionView?.register(nib, forCellWithReuseIdentifier: reuseIdentifier)

        self.collectionView?.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)

        viewModel.reloadTableViewClosure = { [weak self] in
            self?.collectionView?.reloadData()
        }

        viewModel.initFetch()
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
            fatalError("Dequeueing collectionViewCell failed")
        }

        let product = viewModel.getCellViewModel(at: indexPath)
        cell.product = product
        
        return cell
    }

    // MARK: - IndicatorInfoProvider

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

}
