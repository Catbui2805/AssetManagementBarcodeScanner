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
    
    // Load image local storage
    func getImageLocal( _ category: CategoryModel) -> CategoryModel
    
    // Save image local storage
    func saveImageLocal( _ category: CategoryModel)
    
    // Update image local storage
    func updateImageLocal( _ cateogry: CategoryModel)
    
    // Delete image local storage
    func deleteImageLocal(_ category: CategoryModel)
    
    // Delete all image
    
    //----------------------------------
    // Get category by uuid
    func getItem(_ uuid: String) -> CategoryModel?
    
    // Get categories list
    func getAllItem() -> [CategoryModel]
    
    // Save category
    func save(_ category: CategoryModel)
    
    // Update category
    func update(_ category: CategoryModel)
    
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
    
    func save(_ category: CategoryModel) {
        saveImageLocal(category)
        DataManager.shared.save(category)
    }
    
    func update(_ category: CategoryModel) {
        updateImageLocal(category)
        DataManager.shared.update(category)
    }
    
    func delete(_ category: CategoryModel) {
        deleteImageLocal(category)
        DataManager.shared.delete(category)
    }
    
    
    //--------------------------------
    /// Get image to loacal storage
    /// - Parameter category: category
    func getImageLocal(_ category: CategoryModel) -> CategoryModel {
        guard let image = imageLocalStorageServices.getImageFromDocumentDirectory(
            category.name,
            Constants.PathForDirectories.imageCateogry) else { return category }
        category.imageData = image
        return category
    }
    
    
    /// Save image category to local storage
    /// - Parameter : category
    func saveImageLocal( _ category: CategoryModel) {
        guard let image = category.imageData else {
            return
        }
        let _ = imageLocalStorageServices.saveImageDocumentDirectory(
            image,
            category.name,
            Constants.PathForDirectories.imageCateogry)
        DataManager.shared.save(category)
    }
    
    
    /// Update image to local storage
    /// - Parameter cateogries: list categories update
    func updateImageLocal( _ category: CategoryModel) {
        saveImageLocal(category)
    }
    
    
    /// Delete image local storage
    /// - Parameter category: category delete
    func deleteImageLocal(_ category: CategoryModel) {
        let _ = imageLocalStorageServices.deleteImageDocumentInDirectory(
            Constants.PathForDirectories.imageCateogry,
            category.name)
    }
    
}
