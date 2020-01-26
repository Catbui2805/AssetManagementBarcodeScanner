//
//  CategoryModel.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/24/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import UIKit

class CategoryModel: Object {
    @objc dynamic var uuid: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    let assets = List<AssetDetailModel>()
    var isSelected: Bool = false
    
    init(_ uuid: String ,_ name: String, _ image: String, _ isSelected: Bool) {
        self.uuid = uuid
        self.name = name
        self.image = image
        self.isSelected = isSelected
        super.init()
    }

    required init() {
        super.init()
    }
    
    override class func primaryKey() -> String? {
        return "uuid"
    }
}
