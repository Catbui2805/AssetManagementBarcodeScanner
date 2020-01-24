//
//  LanguageViewModel.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation

class LanguageViewModel {
    private var languageList: [LanguageModel] = []
    
    init(_ languageList: [LanguageModel]) {
        self.languageList = languageList
    }
    
    func getItem(_ index: Int) -> LanguageModel {
        return languageList[index]
    }
    
    func getNumberOfList() -> Int {
        return languageList.count
    }
    
    func selectedItem( _ seletedItem: LanguageModel) {
        languageList.forEach { item in
            if item.code == seletedItem.code {
                item.isSelected = true
            } else {
                item.isSelected = false
            }
        }
    }
    
    func getItemSeletedCode() -> String {
        guard let item = languageList.filter({$0.isSelected == true}).first else {
            return LanguageCode.VI.code()
        }
        
        return item.code
    }
    
}
