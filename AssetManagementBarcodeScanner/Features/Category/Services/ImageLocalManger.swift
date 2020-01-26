//
//  ImageLocalManger.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/27/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation
import UIKit


enum PathForDirectories {
    case AssetManager
    case ImageCateogry
    case ImageBarCode
    case ImageQRCode
    case ImageAssets
    case ImageEmployer
    case ImageEmployerQRCode
    case ImageEmployerBarCode
    
    func name() -> String {
        switch self {
        case .AssetManager:
            return "AssetManager"
        case .ImageCateogry:
            return  "ImageCategory"
        case .ImageBarCode:
            return "ImageBarCode"
        case .ImageQRCode:
            return "ImageQRCode"
        case .ImageAssets:
            return "ImageAssets"
        case .ImageEmployer:
            return "ImageEmployer"
        case .ImageEmployerBarCode:
            return "ImageEmployerBarCode"
        case .ImageEmployerQRCode:
            return "ImageEmployerQRCode"
        }
    }
}

protocol ImageLocalMangerable {
    // Get image local
    func getItem( _ directory: PathForDirectories, _ name: String) -> UIImage?
    
    // Save image local
    func save( _ directory: PathForDirectories, _ name: String, _ image: UIImage)
    
    // Update image local
    func update( _ directory: PathForDirectories, _ name: String, _ image: UIImage)
    
    // Delete image in local
    func delete( _ directory: PathForDirectories, _ name: String)
    
}

class ImageLocalManger {
    
    static let shared = ImageLocalManger()
    
    private var imageLocalStorageServices: ImageLocalStorageServicesable
    
    private init() {
        imageLocalStorageServices = ImageLocalStorageServices()
    }
    
}

extension ImageLocalManger: ImageLocalMangerable {
    func getItem(_ directory: PathForDirectories, _ name: String) -> UIImage? {
        guard let image = imageLocalStorageServices.getImageFromDocumentDirectory(
            name, directory.name()) else { return nil }
        return image
    }
    
    
    func save(_ directory: PathForDirectories, _ name: String, _ image: UIImage) {
        let _ = imageLocalStorageServices.saveImageDocumentDirectory(
            image, name, directory.name())
    }
    
    func update(_ directory: PathForDirectories, _ name: String, _ image: UIImage) {
        save(directory, name, image)
    }
    
    func delete(_ directory: PathForDirectories, _ name: String) {
        let _ = imageLocalStorageServices.deleteImageDocumentInDirectory(
            directory.name(), name)
    }
    
}
