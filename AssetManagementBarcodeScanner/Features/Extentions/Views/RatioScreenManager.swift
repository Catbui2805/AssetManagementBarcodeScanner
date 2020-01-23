//
//  RatioScreenManager.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation
import UIKit


// MARK: Ratio Screen Manager CGFloat, Int, Double

extension CGFloat {
    var adjusted: CGFloat {
        return self * Constants.Screen.ratio
    }
}

extension Double {
    var adjusted: CGFloat {
        return CGFloat(self) * CGFloat(Constants.Screen.ratio)
    }
}

extension Int {
    var adjusted: CGFloat {
        return CGFloat(self) * CGFloat(Constants.Screen.ratio)
    }
}
