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
}

