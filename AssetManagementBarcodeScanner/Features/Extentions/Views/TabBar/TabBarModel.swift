//
//  TabBarModel.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation
import UIKit

class TabBarModel {
    var identifier: String
    var viewController: UIViewController
    var title: String
    var image: String
    var selectedImage: String
    var tabBarItemTitle: String
    
    init(_ identifier: String, _ viewController: UIViewController , _ title: String, _ image: String, _ selectedImage: String, _ tabBarItemTitle: String) {
        self.identifier = identifier
        self.viewController = viewController
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
        self.tabBarItemTitle = tabBarItemTitle
    }
}
