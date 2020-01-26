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
    func getImageLocal( _ name: String) -> UIImage?
    
    // Save image local storage
    func saveImageLocal( _ image: UIImage, _ name: String)
    
    // Update image local storage
    func updateImageLocal( _ image: UIImage, _ name: String)
    
    // Delete image local storage
    func deleteImageLocal( _ name: String)
    
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
        if let image = category.imageData {
            saveImageLocal(image, category.image)
        }
        DataManager.shared.save(category)
    }
    
    func update(_ category: CategoryModel) {
        if let image = category.imageData {
            updateImageLocal(image, category.image)
        }
        DataManager.shared.update(category)
    }
    
    // MARK:  delete image forlow uuid

    func delete(_ category: CategoryModel) {
        deleteImageLocal(category.image)
        DataManager.shared.delete(category)
    }
    
    
    //--------------------------------
    /// Get image to loacal storage
    /// - Parameter category: name image of category
    func getImageLocal(_ name: String) -> UIImage? {
        guard let image = imageLocalStorageServices.getImageFromDocumentDirectory(
            name,
            Constants.PathForDirectories.imageCateogry) else { return nil }
        return image
    }
    
    
    /// Save image category to local storage
    func saveImageLocal( _ image: UIImage, _ name: String) {
        let _ = imageLocalStorageServices.saveImageDocumentDirectory(
            image,
            name,
            Constants.PathForDirectories.imageCateogry)
    }
    
    
    /// Update image to local storage
    func updateImageLocal( _ image: UIImage, _ name: String) {
        saveImageLocal(image, name)
    }
    
    /// Delete image local storage
    /// - Parameter name: uuid image in category delete
    func deleteImageLocal(_ name: String) {
        let _ = imageLocalStorageServices.deleteImageDocumentInDirectory(
            Constants.PathForDirectories.imageCateogry,
            name)
    }
    
}
