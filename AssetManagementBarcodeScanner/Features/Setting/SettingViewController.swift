//
//  SettingViewController.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    static let identifier: String = "SettingViewController"
    
    let settingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: Constants.Screen.screenWidth, height: 50.adjusted)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        return cv
    }()
    
    var settingViewModel: SettingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        settingViewModel = SettingViewModel(getSettingList())
    }
}

private extension SettingViewController {
    
    func getSettingList() -> [SettingModel] {
        var settingList: [SettingModel] = []
        
        var languageName = LanguageCode.VI.name()
        if let languageCode = UserDefaults.standard.string(forKey: Constants.UserDefaultKey.LANGUAGEKEY) {
            switch languageCode {
            case LanguageCode.VI.code():
                languageName = LanguageCode.VI.name()
            case LanguageCode.EN.code():
                languageName = LanguageCode.EN.name()
            default:
                languageName = LanguageCode.VI.name()
            }
        }
        let language = SettingModel(0,
                                    Translate.Shared.language(),
                                    "", languageName,
                                    "ic_setting")
        settingList.append(language)
        
        let appVersion = SettingModel(1, Translate.Shared.app_version(), "", "1.0", "")
        settingList.append(appVersion)
        
        let about = SettingModel(2, Translate.Shared.about(), "", "", "")
        settingList.append(about)
        
        return settingList
    }
    
    func setupViews() {
        setupCollectionViewSetting()
        configureRegister()
    }
    
    func setupCollectionViewSetting() {
        view.addSubview(settingCollectionView)
        settingCollectionView.contentInset = .init(top: 20.adjusted, left: 0, bottom: 0, right: 20.adjusted)
        NSLayoutConstraint.activate([
            settingCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureRegister() {
        settingCollectionView.dataSource = self
        settingCollectionView.delegate = self
        settingCollectionView.register(SettingCell.self, forCellWithReuseIdentifier: SettingCell.identifier)
        
    }
}


extension SettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingViewModel.getNumberOfSetting()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell else {
            fatalError("Can't dequeue reusable cell")
        }
        let data = settingViewModel.getItem(indexPath.row)
        cell.configureCell(data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = settingViewModel.getItem(indexPath.row)
        switch item.id {
        case 0:
            let vc = LanguageViewController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
    
}

extension SettingViewController: UICollectionViewDelegateFlowLayout {
    
}

