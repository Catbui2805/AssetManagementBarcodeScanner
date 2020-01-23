//
//  Language.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation

enum LanguageCode {
    case VI
    case EN
    
    func name() -> String {
        switch self {
        case .VI:
            return LanguageManager.Shared.vi()
        case .EN:
            return LanguageManager.Shared.en()
        }
    }
    
    func code() -> String {
        switch self {
        case .VI:
            return "vi"
        case .EN:
            return "en"

        }
    }
}



class LanguageManager {
    
    static let Shared = LanguageManager()
    
    private var language: String = LanguageCode.VI.code()
    
    private init() {
        guard let languageCode = UserDefaults.standard.string(forKey: Constant.UserDefaultKey.LANGUAGEKEY) else { return }
        
        self.language = languageCode
        
    }
    
    func getLanguage() -> String {
        return language
    }
    
    func setLanguage(_ language: String) {
        self.language = language
    }
    
}


// MARK:  Translate Language

extension LanguageManager {
    
    // MARK:  Language

    func vi() -> String {
        return "vi".localized()
    }
    
    func en() -> String {
        return "en".localized()
    }

}
