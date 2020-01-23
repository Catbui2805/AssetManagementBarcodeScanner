//
//  SettingModel.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation

class SettingModel {
    var id: Int
    var title: String
    var status: String
    var desc: String
    var image: String
    
    init(_ id: Int, _ title: String, _ status: String, _ desc: String, _ image: String) {
        self.id = id
        self.title = title
        self.status = status
        self.desc = desc
        self.image = image
    }
}
