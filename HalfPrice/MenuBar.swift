//
//  MenuBar.swift
//  HalfPrice
//
//  Created by QueenaHuang on 17/4/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit
import SnapKit

let cellWidth:CGFloat = 100.0

enum CategoryName: String {
    case hot = "Hot"
    case frozen = "Frozen"
    case drinks = "Drinks"
    case household = "Household"
    case beauty = "Beauty"
    case living = "Living"
    case international = "International"
    case dairy = "Dairy"
    case bakery = "Bakery"
    case meat = "Meat"
    case stationery = "Stationery"
    case pet = "Pet"
    case alcohol = "Alcohol"
}

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource,
                UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.blue
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    let cellId = "cellId"
    let tagNames: [CategoryName] = [.hot, .frozen, .drinks, .household, .beauty, .living, .international, .dairy, .bakery, .meat, .stationery, .pet, .alcohol]

    var homeController: ViewController?
    var menuIndex = 0

    override init(frame: CGRect) {
        super.init(frame: frame)

        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)

        addSubview(collectionView)

        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }

        let selectedIndexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom)

//        collectionView.showsHorizontalScrollIndicator = false

        setupHorizontalBar()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var horizontalBarLeftAnchorConstraint: Constraint?

    private func setupHorizontalBar() {
        let horizontalBar = UIView()
        horizontalBar.backgroundColor = UIColor.red
        horizontalBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBar)

        horizontalBar.snp.makeConstraints { (make) in
            horizontalBarLeftAnchorConstraint = make.left.equalTo(self.snp.left).offset(0).constraint
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(cellWidth)
            make.height.equalTo(4)
        }
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offset = cellWidth * CGFloat(menuIndex)

        let frame = offset - collectionView.contentOffset.x

        horizontalBarLeftAnchorConstraint?.update(offset: frame)

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagNames.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                            for: indexPath) as? MenuCell else {
            fatalError("Dequeueing collectionViewCell failed")
        }

        let colors: [UIColor] = [UIColor.purple, UIColor.blue, UIColor.green, UIColor.darkGray]
        cell.backgroundColor = colors[indexPath.row % 4]

        cell.titleLabel.text = "\(indexPath.row)\(tagNames[indexPath.row].rawValue)"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: frame.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

//        let offset = collectionView.contentOffset
//        let frameX = CGFloat(menuIndex) * cellWidth - offset.x
//        horizontalBarLeftAnchorConstraint?.update(offset: frameX)
//
//        
//        UIView.animate(withDuration: 0.75, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)

        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)

    }

}

class MenuCell: UICollectionViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.red
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    override var isHighlighted: Bool {
        didSet {
            titleLabel.textColor = isHighlighted ? UIColor.white : UIColor.red
        }
    }

    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? UIColor.white : UIColor.red
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }

}
