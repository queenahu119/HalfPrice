//
//  ProductCell.swift
//  HalfPrice
//
//  Created by QueenaHuang on 16/4/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit
import SnapKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var labelBrand: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    var product: ProductCellViewModel? {
        didSet {
            labelName.text = product?.titleText
            labelBrand.text = product?.brandText
            labelDescription.text = product?.descText

            if let imageUrl = product?.imageUrl {
                productImageView.imageFromServerURL(url: imageUrl)
            }

            if let price = product?.price {
                let attribute = [ NSAttributedStringKey.foregroundColor: UIColor.red , NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28)]
                let attrString = NSMutableAttributedString(string: "$\(price.format(".2")) ", attributes: attribute)

                if let wasPrice = product?.pastPrice {
                    let attrPastPriceString = NSAttributedString(string: "was $\(wasPrice.format(".2"))")
                    attrString.append(attrPastPriceString)
                }

                labelPrice.attributedText = attrString
            }

            // Adjust text's height
            let size = CGSize(width: frame.width - 20*2 - 8 - 150, height: 1000)
            let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimateRect = NSString(string: labelName.text!).boundingRect(with: size, options: option, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14)], context: nil)
            if estimateRect.size.height > 20 {
                labelName.snp.updateConstraints { (make) in
                    make.height.equalTo(44)
                }
            } else {
                labelName.snp.updateConstraints { (make) in
                    make.height.equalTo(20)
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupUI() {
        let padding = UIEdgeInsets(top: 20, left: 20, bottom: -20, right: -20)

        productImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(padding.left)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(150)
        }

        labelBrand.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(padding.top)
            make.left.equalTo(productImageView.snp.right).offset(8)
            make.right.equalTo(self.snp.right).offset(padding.right)
            make.height.equalTo(20)
        }

        labelName.numberOfLines = 2
        labelName.snp.makeConstraints { (make) in
            make.top.equalTo(labelBrand.snp.bottom).offset(8)
            make.left.right.equalTo(labelBrand)
            make.height.equalTo(20)
        }

        labelPrice.snp.makeConstraints { (make) in
            make.top.equalTo(labelName.snp.bottom).offset(8)
            make.left.right.equalTo(labelBrand)
            make.height.equalTo(40)
        }
        labelDescription.snp.makeConstraints { (make) in
            make.top.equalTo(labelPrice.snp.bottom).offset(8)
            make.left.equalTo(labelBrand)
            make.right.equalTo(likeButton.snp.left).offset(-8)
            make.height.equalTo(20)
        }
        likeButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(padding.bottom)
            make.right.equalTo(self.snp.right).offset(padding.right)
            make.size.equalTo(30)
        }

        likeButton.setImage(UIImage(named: "Button_like_h"), for: .normal)
    }

}
