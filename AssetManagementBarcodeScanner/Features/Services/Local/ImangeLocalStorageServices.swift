//
//  ImangeLocalStorageServices.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/25/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation
import UIKit



protocol ImageLocalStorageServicesable {
    
    // Load image
    func getImageFromDocumentDirectory( _ imageName: String, _ pathName: String) -> UIImage?
    
    // Save image
    func saveImageDocumentDirectory( _ image: UIImage, _ imageName: String, _ pathName: String)
    
    // Delete image
    func deleteImageDocumentInDirectory(_ pathName: String, _ imageName: String)
    
    // Delete directory
    func deleteDirectory(_ pathName: String)
    
    // Configure directory
    func configureDirectory() -> String
    
}

class ImageLocalStorageServices: ImageLocalStorageServicesable {
    
    /// Get image from document directory
    /// - Parameter imageName: name image
    /// - Parameter pathName: name path of directory
    func getImageFromDocumentDirectory( _ imageName: String, _ pathName: String) -> UIImage? {
        let fileManager = FileManager.default
        let imagePath = (self.getDirectoryPath(pathName) as NSURL).appendingPathComponent("\(imageName)")
        let urlString: String = imagePath!.absoluteString
        if fileManager.fileExists(atPath: urlString) {
            return UIImage(contentsOfFile: urlString)
        } else {
            return nil
        }
        
    }
    
    
    /// Get directory path of app save image
    /// - Parameter pathName: path name
    func getDirectoryPath( _ pathName: String) -> NSURL {
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(pathName)
        let url = NSURL(string: path)
        return url!
    }
    
    
    /// Configure directory of app
    func configureDirectory() -> String {
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(PathForDirectories.AssetManager.name())
        if !fileManager.fileExists(atPath: path) {
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        return path
    }
    
    
    /// Save image document directory
    /// - Parameter image: file image
    /// - Parameter imageName: name image
    /// - Parameter pathName: name of directory
    func saveImageDocumentDirectory( _ image: UIImage, _ imageName: String, _ pathName: String) {
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(pathName)
        if !fileManager.fileExists(atPath: path) {
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        let url = NSURL(string: path)
        let imagePath = url!.appendingPathComponent(imageName)
        let urlString: String = imagePath!.absoluteString
        let imageData = image.jpegData(compressionQuality: 0.5)
        fileManager.createFile(atPath: urlString as String, contents: imageData, attributes: nil)
    }
    
    
    func deleteImageDocumentInDirectory(_ pathName: String, _ imageName: String) {
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(pathName)
        do {
            try fileManager.removeItem(atPath: "\(path)/\(imageName)")
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
    
    
    /// Delete directory
    /// - Parameter pathName: name of directory
    func deleteDirectory(_ pathName: String) {
        let fileManager = FileManager.default
        let yourProjectImagesPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(pathName)
        if fileManager.fileExists(atPath: yourProjectImagesPath) {
            try! fileManager.removeItem(atPath: yourProjectImagesPath)
        }
        let yourProjectDirectoryPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(PathForDirectories.AssetManager.name())
        if fileManager.fileExists(atPath: yourProjectDirectoryPath) {
            try! fileManager.removeItem(atPath: yourProjectDirectoryPath)
        }
    }
    
}

