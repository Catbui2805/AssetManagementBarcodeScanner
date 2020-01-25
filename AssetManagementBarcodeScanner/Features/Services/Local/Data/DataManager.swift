//
//  DataManager.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/25/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class DataManager {
    
    static let shared = DataManager()
    
    private var data: Realm
    
    private init() {
        data = try! Realm()
    }
}

extension DataManager {
    
    /// Save object to database
    /// - Parameter object: need to save
    func save(_ object: Object) {
        try? data.write {
            data.add(object, update: .error)
        }
    }
    
    
    /// Update object in database
    /// - Parameter object: need to update
    func update(_ object: Object) {
        try? data.write {
            data.add(object, update: .all)
        }
    }
    
    
    /// Delete object in database
    /// - Parameter object: need to delete
    func delete(_ object: Object) {
        try? data.write {
            data.delete(object)
        }
    }
    
    
    /// Get data
    /// - Parameter type: object need to get
    func getObject(_ type: Object.Type) -> [Object] {
        return Array(data.objects(type))
    }
    
    /// Clear database
    func deleteAll() {
        try! data.write {
            data.deleteAll()
        }
    }
}
