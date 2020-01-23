//
//  String+Color.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var color: UIColor {
        return UIColor.fromHex(self)
    }
}
