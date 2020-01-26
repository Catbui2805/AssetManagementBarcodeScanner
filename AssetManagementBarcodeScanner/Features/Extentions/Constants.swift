//
//  Constants.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/21/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation
import UIKit

enum CRUDType {
    case Create
    case Read
    case Update
    case Delete
}

enum Constants {
    
    enum Screen {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        static let ratio: CGFloat = Constants.Screen.screenWidth / 375
    }
    
    enum Fonts {
        
        // MARK:  Setting
        static let settingTitleCell = Constants.Fonts.regular16
        
        // MARK:  Home
        
        // MARK:  Category
        
        // MARK:  Scanner
        
        // MARK:  Common
        static let regular16 = UIFont.systemFont(ofSize: 16.adjusted, weight: .regular)
        static let regular14 = UIFont.systemFont(ofSize: 14.adjusted, weight: .regular)

        
    }
    enum Strings {
        
    }
    enum Colors {
        // MARK:  Setting
        static let settingTitleCell = Constants.Colors.color222222
        static let settingDescCell = Constants.Colors.color777878
        

        
        // MARK:  common
        static let colorLine = UIColor.fromHex("#607D8B").withAlphaComponent(0.5)
        static let color222222 = UIColor.fromHex("#222222")
        static let color777878 = UIColor.fromHex("#777878")

    }
    
    enum UserDefaultKey {
        static let LANGUAGEKEY = "languageKey"
    }
    
    enum PathForDirectories {
        static let assetManager = "AssetManager"
        static let imageCateogry = "ImageCategory"
        static let imageBarCode = "ImageBarCode"
        static let imageQRCode = "ImageQRCode"
    }
}
