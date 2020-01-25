//
//  CategoryViewController.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    static let identifier: String = "CategoryViewController"
    
    private var categoryViewModel: CategoryViewModel!
    private var categoryServices: CategoryImageSeviceable!
    
    private let cvCategories: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.estimatedItemSize = CGSize(width: 80.adjusted, height: 100.adjusted)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .white
        return cv
    }()
    
    var rightBarButtonItem = UIBarButtonItem()
    
    var shouldEdit: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryServices = CategoryServices()
        categoryViewModel = CategoryViewModel(getCategories())
        setupViews()
        
    }
    
    @objc func tappedEdit() {
        if shouldEdit {
            rightBarButtonItem.title = Translate.Shared.edit()
        } else {
            rightBarButtonItem.title = Translate.Shared.done()
        }
        shouldEdit = !shouldEdit
    }
}

private extension CategoryViewController {
    
    // MARK:  Get some data for category
    
    func getCategories() -> [CategoryModel] {
        var categories: [CategoryModel] = []
        let pc = CategoryModel(UUID().uuidString, "PC", "ic_pc_color", nil, false)
        categories.append(pc)
        
        let laptop = CategoryModel(UUID().uuidString, "Laptop", "ic_laptop",nil, false)
        categories.append(laptop)
        
        let monitor = CategoryModel(UUID().uuidString, "Monitor", "ic_monitor", nil, false)
        categories.append(monitor)
        
        let phone = CategoryModel(UUID().uuidString, "Devices Phone", "ic_phone", nil, false)
        categories.append(phone)
        
        let keyboard = CategoryModel(UUID().uuidString, "Keyboard", "ic_keyboard", nil, false)
        categories.append(keyboard)
        
        let cable = CategoryModel(UUID().uuidString, "Cable", "ic_cable", nil, false)
        categories.append(cable)
        
        let card = CategoryModel(UUID().uuidString, "Card", "ic_card", nil, false)
        categories.append(card)
        
        let headset = CategoryModel(UUID().uuidString, "Headset", "ic_headset", nil, true)
        categories.append(headset)
        
        return categories
    }
    
    func setupViews() {
        configureView()
        setupNavigation()
        setupCollectionViewCategory()
    }
    
    func configureView() {
        cvCategories.dataSource = self
        cvCategories.delegate = self
        cvCategories.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    
    func setupNavigation() {
        rightBarButtonItem = UIBarButtonItem(title: Translate.Shared.edit(), style: .plain, target: self, action: #selector(tappedEdit))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupCollectionViewCategory() {
        view.addSubview(cvCategories)
        cvCategories.contentInset = .init(top: 40.adjusted, left: 20.adjusted, bottom: 40.adjusted, right: 20.adjusted)
        cvCategories.frame = view.frame
    }
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryViewModel.getNumberOfCategories()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            fatalError("Can't dequeue reusable cell")
        }
        
        let data = categoryViewModel.getItem(indexPath.row)
        cell.configureCell(data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if shouldEdit {
            let alert = UIAlertController(title: categoryViewModel.getItem(indexPath.row).name, message: Translate.Shared.would_you_like_to_choise_some_options_edit() , preferredStyle: .actionSheet)
            let create = UIAlertAction(title: Translate.Shared.create_category(), style: .default, handler: { (action) -> Void in
                
                let vc = CreateCategoryViewController()
                vc.hidesBottomBarWhenPushed = true
                vc.title = Translate.Shared.create_category()
                vc.type = CategoryType.Create
                vc.addCategory = { [weak self] item in
                    self?.categoryViewModel.addNewItem(item)
                    self?.cvCategories.reloadData()
                }
                self.navigationController?.pushViewController(vc, animated: true)
                
            })
            
            let edit = UIAlertAction(title: Translate.Shared.edit(), style: .default) { _ in
                let vc = CreateCategoryViewController()
                vc.hidesBottomBarWhenPushed = true
                vc.title = Translate.Shared.edit()
                vc.type = CategoryType.Edit
                vc.category = self.categoryViewModel.getItem(indexPath.row)
                vc.addCategory = { [weak self] item in
                    self?.categoryViewModel.editItem(indexPath.row, item)
                    self?.cvCategories.reloadItems(at: [indexPath])
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            let delete = UIAlertAction(title: Translate.Shared.delete(), style: .default) { _ in
                self.categoryServices.deleteImageLocal(self.categoryViewModel.getItem(indexPath.row))
                self.categoryViewModel.deleteItem(indexPath.row)
                self.cvCategories.reloadData()
            }
            let cancel = UIAlertAction(title: Translate.Shared.cancel(), style: .cancel, handler: nil)
            
            alert.addAction(create)
            alert.addAction(edit)
            alert.addAction(delete)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 80.adjusted, height: 100.adjusted)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40.adjusted
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20.adjusted
    }
}

