//
//  AssetDetailModel.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/25/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

enum AssetStatus {
    case NORMAL
    case STOCK
    case EXPLOITATION
    case NOTFOUND
    case BROKEN
    
    func name() -> String {
        switch self {
        case .NORMAL:
            return "NORMAL"
        case .STOCK:
            return "STOCK"
        case .EXPLOITATION:
            return "EXPLOITATION"
        case .NOTFOUND:
            return "NOTFOUND"
        case .BROKEN:
            return "BROKEN"
        }
    }
    
    
}

class AssetDetailModel: Object {
    let ofCategory = LinkingObjects(fromType: CategoryModel.self, property: "assets")
    @objc dynamic var uuid: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var label: String = ""
    @objc dynamic var seriNumber: String = ""
    @objc dynamic var assetStatus: String = ""
    @objc dynamic var note: String = ""
    @objc dynamic var imageAsset: String = ""
    @objc dynamic var imageBarCode: String = ""
    @objc dynamic var imageQRCode: String = ""
    @objc dynamic var dateOfPurchase: Date = Date()
    @objc dynamic var price: Double = 0.0
    @objc dynamic var dateUpdate: Date = Date()
    
    override class func primaryKey() -> String? {
        return "uuid"
    }
    
    init( _ uuid: String, _ name: String, _ label: String, _ seriNumber: String, _ assetStatus: String, _ note: String, _ imageAsset: String, _ imageBarCode: String, _ imageQRCode: String, _ dateOfPurchase: Date, _ price: Double, _ dateUpdate: Date) {
        
        self.uuid = uuid
        self.name = name
        self.label = label
        self.seriNumber = seriNumber
        self.assetStatus = assetStatus
        self.note = note
        self.imageAsset = imageAsset
        self.imageBarCode = imageBarCode
        self.imageQRCode = imageQRCode
        self.dateOfPurchase = dateOfPurchase
        self.price = price
        self.dateUpdate = dateUpdate
        
        super.init()
    }
    
    convenience init( _ uuid: String, _ name: String, _ imageAsset: String, _ imageBarCode: String, _ imageQRCode: String) {
        
        self.init()
        self.uuid = uuid
        self.name = name
        self.imageAsset = imageAsset
        self.imageBarCode = imageBarCode
        self.imageQRCode = imageQRCode
    }
    
    required init() {
        super.init()
    }
    
}
