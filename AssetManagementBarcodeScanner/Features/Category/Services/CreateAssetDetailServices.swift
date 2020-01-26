//
//  CreateAssetDetailServices.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/27/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift

protocol CreateAssetDetailServicesable {
    // Get data by UUID
    func getItem( _ uuid: String) -> AssetDetailModel?
    
    // Get all data
    func getAll() -> [AssetDetailModel]
    
    // Save data
    func save(_ item: AssetDetailModel, _ image: UIImage)
    
    // Update data
    func update( _ item: AssetDetailModel, _ image: UIImage)
    
    // Delete data
    func delete( _ item: AssetDetailModel)
    
}

class CreateAssetDetailServices {

}

extension CreateAssetDetailServices: CreateAssetDetailServicesable {
    
    func getItem(_ uuid: String) -> AssetDetailModel? {
        let data = try! Realm()
        return data.object(ofType: AssetDetailModel.self, forPrimaryKey: uuid)
    }
    
    func getAll() -> [AssetDetailModel] {
        guard let data = DataManager.shared.getObject(AssetDetailModel.self) as? [AssetDetailModel] else {
            return []
        }
        return data
    }
    
    func save(_ item: AssetDetailModel, _ image: UIImage) {
        ImageLocalManger.shared.save(.ImageAssets, item.imageAsset, image)
        DataManager.shared.save(item)
    }
    
    func update(_ item: AssetDetailModel, _ image: UIImage) {
        ImageLocalManger.shared.update(.ImageAssets, item.imageAsset, image)
        DataManager.shared.save(item)
    }
    
    func delete(_ item: AssetDetailModel) {
        ImageLocalManger.shared.delete(.ImageAssets, item.imageAsset)
    }
    
}
