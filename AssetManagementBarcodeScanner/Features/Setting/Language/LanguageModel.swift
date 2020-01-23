//
//  LanguageModel.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation

class LanguageModel {
    var id: Int
    var name: String
    var code: String
    var isSelected: Bool = false

    init(_ id: Int, _ name: String, _ code: String, _ isSelected: Bool) {
        self.id = id
        self.name = name
        self.code = code
        self.isSelected = isSelected
    }
}
