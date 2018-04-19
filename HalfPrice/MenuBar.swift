//
//  MenuBar.swift
//  HalfPrice
//
//  Created by QueenaHuang on 17/4/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit
import SnapKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.blue
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    let cellId = "cellId"

    override init(frame: CGRect) {
        super.init(frame: frame)

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)

        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.red
        
        return cell
    }


}
