//
//  ProductCell.swift
//  HalfPrice
//
//  Created by QueenaHuang on 16/4/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit
import SnapKit

let sizeOfProductImage: CGFloat = 80

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var labelBrand: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    let padding = UIEdgeInsets(top: 10, left: 20, bottom: -10, right: -20)

    var product: ProductCellViewModel? {
        didSet {
            labelName.text = product?.titleText
            labelBrand.text = product?.brandText
            labelDescription.text = product?.descText

            if let imageUrl = product?.imageUrl {
                productImageView.imageFromServerURL(urlString: imageUrl)
            }

            if let price = product?.price {
                let attribute = [ NSAttributedStringKey.foregroundColor: UIColor.red,
                                  NSAttributedStringKey.font: UIFont.systemFont(ofSize: 22)]
                let formatString = price.format(".2")
                let attrString = NSMutableAttributedString(string: "$\(formatString) ", attributes: attribute)

                if let wasPrice = product?.pastPrice {
                    let attribute = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                                      NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
                    let formatString = wasPrice.format(".2")
                    let attrPastPriceString =
                        NSMutableAttributedString(string: "was $\(formatString)", attributes: attribute)
                    attrString.append(attrPastPriceString)
                }

                labelPrice.attributedText = attrString
            }

            // Adjust text's height
            if let text = labelName.text {
                let size = CGSize(width: frame.width - padding.left*2 - 8 - sizeOfProductImage, height: 1000)
                let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let attributes = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 16)]
                let estimateRect = NSString(string: text).boundingRect(with: size,
                                                                       options: option,
                                                                       attributes:attributes,
                                                                       context: nil)
                if estimateRect.size.height > 20 {
                    labelName.snp.updateConstraints { (make) in
                        make.height.equalTo(40)
                    }
                } else {
                    labelName.snp.updateConstraints { (make) in
                        make.height.equalTo(20)
                    }
                }
            }

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = UIColor.white
        setupUI()
    }

    func setupUI() {
        labelBrand.font = UIFont.systemFont(ofSize: 14)
        labelName.font = UIFont.boldSystemFont(ofSize: 16)
        labelDescription.font = UIFont.systemFont(ofSize: 14)

        productImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(padding.left)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(sizeOfProductImage)
        }

        labelBrand.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(padding.top)
            make.left.equalTo(productImageView.snp.right).offset(8)
            make.right.equalTo(likeButton.snp.left).offset(-8)
            make.height.equalTo(20)
        }

        labelName.numberOfLines = 2
        labelName.snp.makeConstraints { (make) in
            make.top.equalTo(labelBrand.snp.bottom)
            make.left.equalTo(labelBrand)
            make.right.equalTo(self.snp.right).offset(padding.right)
            make.height.equalTo(20)
        }

        labelPrice.snp.makeConstraints { (make) in
            make.top.equalTo(labelName.snp.bottom)
            make.left.right.equalTo(labelBrand)
            make.height.equalTo(40)
        }
        labelDescription.snp.makeConstraints { (make) in
            make.top.equalTo(labelPrice.snp.bottom)
            make.left.right.equalTo(labelBrand)
            make.bottom.equalTo(self.snp.bottom).offset(padding.bottom).priority(.low)
            make.height.equalTo(20)
        }
        likeButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(padding.bottom)
            make.left.right.equalTo(labelDescription.snp.right).offset(-8).priority(.low)
            make.right.equalTo(self.snp.right).offset(padding.right)
            make.size.equalTo(30)
        }

        likeButton.setImage(UIImage(named: "Button_like_h"), for: .normal)
    }

}
