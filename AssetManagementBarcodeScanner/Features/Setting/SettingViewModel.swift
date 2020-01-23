//
//  SettingViewModel.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation

class SettingViewModel {
    private var settingList: [SettingModel] = []
    
    init(_ settingList: [SettingModel]) {
        self.settingList = settingList
    }
    
    func getItem(_ index: Int) -> SettingModel {
        return settingList[index]
    }
    
    func getNumberOfSetting() -> Int {
        return settingList.count
    }
    
}
