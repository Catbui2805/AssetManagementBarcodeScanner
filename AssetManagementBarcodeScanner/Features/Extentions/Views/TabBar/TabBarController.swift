//
//  TabBarController.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
}

private extension TabBarController {
    func setupViews() {
        guard let bundleName = Bundle.main.infoDictionary!["CFBundleName"] as? String else { return }
        
        self.viewControllers = getTabBarList().compactMap({ item in
            
            let viewController = item.viewController
            viewController.view.backgroundColor = .white
            viewController.title = item.title
            viewController.tabBarItem.image = UIImage(named: item.image)?
                .withRenderingMode(.alwaysTemplate)
            viewController.tabBarItem.selectedImage = UIImage(named: item.selectedImage)?
                .withRenderingMode(.alwaysTemplate)
            viewController.tabBarItem.title = item.tabBarItemTitle
            
            let navigationController = UINavigationController(rootViewController: viewController)
            
            return navigationController
            
        })
    }
    
    func getTabBarList() -> [TabBarModel] {
        var tabList: [TabBarModel] = []
        
        // MARK:  home
        let home = TabBarModel(HomeViewController.identifier,
                               HomeViewController(),
                               Translate.Shared.home(),
                               "ic_home_default",
                               "",
                               Translate.Shared.home())
        tabList.append(home)
        
        // MARK:  category
        let category = TabBarModel(CategoryViewController.identifier,
                                   CategoryViewController(),
                                   Translate.Shared.category(),
                                   "ic_category_default",
                                   "",
                                   Translate.Shared.category())
        tabList.append(category)
        
        // MARK:  Scanner
        let scanner = TabBarModel(ScannerViewController.identifier,
                                  ScannerViewController(),
                                  Translate.Shared.scanner(),
                                  "",
                                  "",
                                  Translate.Shared.scanner())
        tabList.append(scanner)
        
        // MARK:  Setting
        let setting = TabBarModel(SettingViewController.identifier,
                                  SettingViewController(),
                                  Translate.Shared.setting(),
                                  "ic_setting",
                                  "",
                                  Translate.Shared.setting())
        tabList.append(setting)
        return tabList
    }
    
}
