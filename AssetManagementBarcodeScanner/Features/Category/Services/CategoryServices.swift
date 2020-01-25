//
//  CategoryServices.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/25/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation
import UIKit


protocol CategoryImageSeviceable {
    
    // Load image local storage
    func getImageLocal( _ category: CategoryModel) -> UIImage?
    
    // Save image local storage
    func saveImageLocal( _ category: CategoryModel)
    
    // Update image local storage
    func updateImageLocal( _ cateogry: CategoryModel)
    
    // Delete image local storage
    func deleteImageLocal(_ category: CategoryModel)
    
    // Delete all image
    
    
}

protocol CategoryDataSeviceable {
    
    
}

class CategoryServices {
    private let imageLocalStorageServices: ImageLocalStorageServicesable = ImageLocalStorageServices()
}

extension CategoryServices: CategoryImageSeviceable {
    
    /// Get image to loacal storage
    /// - Parameter category: category
    func getImageLocal(_ category: CategoryModel) -> UIImage? {
        guard let image = imageLocalStorageServices.getImageFromDocumentDirectory(
            category.uuid,
            Constants.PathForDirectories.imageCateogry) else { return nil }
        return image
    }
    
    
    /// Save image category to local storage
    /// - Parameter : category
    func saveImageLocal( _ category: CategoryModel) {
        guard let image = category.imageData else {
            return
        }
        let _ = imageLocalStorageServices.saveImageDocumentDirectory(
            image,
            category.uuid,
            Constants.PathForDirectories.imageCateogry)
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
            category.uuid)
    }
    
}

extension CategoryServices: CategoryDataSeviceable {
    
}
