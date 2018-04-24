//
//  Common.swift
//  HalfPrice
//
//  Created by QueenaHuang on 16/4/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    func imageFromServerURL(urlString: String) {

        Alamofire.request(urlString).responseImage { response in

            if let image = response.result.value {
                self.image = image
            }
        }
    }
}

extension Float {
    func format(_ formatString: String) -> String {
        return String(format: "%\(formatString)f", self)
    }
}
