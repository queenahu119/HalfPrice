//
//  ProductCell.swift
//  HalfPrice
//
//  Created by QueenaHuang on 16/4/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var labelBrand: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupUI() {
        
    }


}
