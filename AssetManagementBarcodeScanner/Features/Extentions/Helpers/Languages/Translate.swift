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
    func home() -> String {
        return "home".localized()
    }
}

