//
//  CategoryServices.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/25/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift


protocol CategoryServicesable {
    
    // Get category by uuid
    func getItem(_ uuid: String) -> CategoryModel?
    
    // Get categories list
    func getAllItem() -> [CategoryModel]
    
    // Save category
    func save(_ category: CategoryModel, _ image: UIImage)
    
    // Update category
    func update(_ category: CategoryModel, _ image: UIImage)
    
    // Delete category
    func delete(_ category: CategoryModel)
    
    // Delete All category
    
    
}

class CategoryServices {
    private let imageLocalStorageServices: ImageLocalStorageServicesable = ImageLocalStorageServices()
}

extension CategoryServices: CategoryServicesable {
    
    func getItem(_ uuid: String) -> CategoryModel? {
        let data = try! Realm()
        return data.object(ofType: CategoryModel.self, forPrimaryKey: uuid)
    }
    
    
    func getAllItem() -> [CategoryModel] {
        guard let data = DataManager.shared.getObject(CategoryModel.self) as? [CategoryModel] else { return [] }
        return data
    }
    
    
    func save(_ category: CategoryModel, _ image: UIImage) {
        ImageLocalManger.shared.save(.ImageCateogry, category.image, image)
        DataManager.shared.save(category)
    }
    
    
    func update(_ category: CategoryModel, _ image: UIImage) {
        ImageLocalManger.shared.update(.ImageCateogry, category.image, image)
        DataManager.shared.update(category)
    }
    
    
    // MARK:  delete image forlow uuid
    func delete(_ category: CategoryModel) {
        ImageLocalManger.shared.delete(.ImageCateogry, category.image)
        DataManager.shared.delete(category)
    }
    
}
