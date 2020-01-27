//
//  Translate.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation

class Translate {
    
    static let Shared = Translate()
    
    private init() {}
    
}

// MARK:  Translate language

extension Translate {
    
    // MARK:  title Tabbar and title navigation

    func home() -> String {
        return "home".localized()
    }
    
    func category() -> String {
        return "category".localized()
    }
    
    func scanner() -> String {
        return "scanner".localized()
    }
    
    func setting() -> String {
        return "setting".localized()
    }
    
    // MARK:  Setting
    func language() -> String {
        return "language".localized()
    }
    
    func app_version() -> String {
        return "app_version".localized()
    }

    func ok() -> String {
        return "ok".localized()
    }
    
    func about() -> String {
        return "about".localized()
    }
    
    // MARK:  Category screen
    
    func add_image() -> String {
        return "add_image".localized()
    }
    
    func please_enter_name_category() -> String {
        return "please_enter_name_category".localized()
    }
    
    func name_category() -> String {
        return "name_category".localized()
    }
    
    func edit() -> String {
        return "edit".localized()
    }
    
    func edit_category() -> String {
        return "edit_category".localized()
    }
    
    func would_you_like_to_choise_some_options_edit() -> String {
        return "would_you_like_to_choise_some_options_edit".localized()
    }
    
    func create_category() -> String {
        return "create_category".localized()
    }
    
    func cancel() -> String {
        return "cancel".localized()
    }
    
    func delete() -> String {
        return "delete".localized()
    }
    
    func options() -> String {
        return "options".localized()
    }
    
    func save() -> String {
        return "save".localized()
    }
    
    func done() -> String {
        return "done".localized()
    }
    
    func add() -> String {
        return "add".localized()
    }
    
    func update() -> String {
        return "update".localized()
    }
    
    func category_update() -> String{
        return "category_update".localized()
    }
    
    func asset_update() -> String {
        return "asset_update".localized()
    }
    
    func create_asset() -> String {
        return "create_asset".localized()
    }
    
    func read() -> String {
        return "read".localized()
    }
    
    func create() -> String {
        return "create".localized()
    }
    
}

