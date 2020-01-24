//
//  LanguageViewController.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {
    
    static let identifier: String = "LanguageViewController"
    
    let cvLanguage: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: Constants.Screen.screenWidth, height: 50.adjusted)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        return cv
    }()
    
    private var languageViewModel: LanguageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageViewModel = LanguageViewModel(getLanguageList())
        setupViews()
    }
    
    
    @objc func tappedChangeLanguage() {
        let languageCode = languageViewModel.getItemSeletedCode()
        UserDefaults.standard.set(languageCode, forKey: Constants.UserDefaultKey.LANGUAGEKEY)
        LanguageManager.Shared.setLanguage(languageCode)
        restartApplication()
    }
    
    func restartApplication () {
        
        let tabBar = TabBarController()
        
        guard
            let window = UIApplication.shared.keyWindow,
            let rootViewController = window.rootViewController
            else { return }
        
        tabBar.view.frame = rootViewController.view.frame
        tabBar.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.3, options: .curveEaseIn, animations: {
            window.rootViewController = tabBar
        })
    }
    
}

private extension LanguageViewController {
    
    func getLanguageList() -> [LanguageModel] {
        var languageList: [LanguageModel] = []
        
        let vietnam = LanguageModel(0, LanguageCode.VI.name(), LanguageCode.VI.code(), true)
        languageList.append(vietnam)
        
        let english = LanguageModel(1, LanguageCode.EN.name(), LanguageCode.EN.code(), false)
        languageList.append(english)
        
        if let languageCode = UserDefaults.standard.string(forKey: Constants.UserDefaultKey.LANGUAGEKEY) {
            languageList.forEach { item in
                if item.code == languageCode {
                    item.isSelected = true
                } else {
                    item.isSelected = false
                }
            }
        }
        
        return languageList
    }
    
    func setupViews() {
        setupNavigationController()
        setupCollectionView()
        configureRegister()
    }
    
    func setupNavigationController() {
        let rightBarButtonItem = UIBarButtonItem(title: Translate.Shared.ok(), style: .plain, target: self, action: #selector(tappedChangeLanguage))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupCollectionView() {
        view.addSubview(cvLanguage)
        cvLanguage.frame = view.frame
        cvLanguage.contentInset = .init(top: 20.adjusted, left: 0, bottom: 0, right: 20.adjusted)
    }
    
    func configureRegister() {
        cvLanguage.delegate = self
        cvLanguage.dataSource = self
        cvLanguage.register(LanguageCell.self, forCellWithReuseIdentifier: LanguageCell.identifier)
    }
    
}

extension LanguageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return languageViewModel.getNumberOfList()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LanguageCell.identifier, for: indexPath) as? LanguageCell else {
            fatalError("Can't dequeue reusable cell")
        }
        
        let data = languageViewModel.getItem(indexPath.row)
        cell.configureCell(data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let getItem = languageViewModel.getItem(indexPath.row)
        let _ = languageViewModel.selectedItem(getItem)
        cvLanguage.reloadData()
    }
    
}

extension LanguageViewController: UICollectionViewDelegateFlowLayout {
    
}
