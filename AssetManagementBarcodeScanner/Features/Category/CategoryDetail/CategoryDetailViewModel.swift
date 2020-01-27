//
//  CategoryDetailViewModel.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/25/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation

class CategoryDetailViewModel {
    private var assets: [AssetDetailModel] = []
    
    init( _ assets: [AssetDetailModel]) {
        self.assets = assets
    }
    
    func update( _ assets: [AssetDetailModel]) {
        self.assets = assets
    }
    
    func addItem( _ asset: AssetDetailModel) {
        self.assets.append(asset)
    }
    
    func numberOfAssets() -> Int {
        return self.assets.count
    }
    
    func deleteItem( _ index: Int) {
        self.assets.remove(at: index)
    }
    
    func getItem( _ index: Int) -> AssetDetailModel {
        return self.assets[index]
    }
    
    func getAll() -> [AssetDetailModel] {
        return self.assets
    }
    
    func editItem( _ index: Int, _ item: AssetDetailModel) {
        self.assets[index] = item
    }
    
}
