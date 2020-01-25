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
    private var categoryServices: CategoryServicesable!
    
    private let cvCategories: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.estimatedItemSize = CGSize(width: 80.adjusted, height: 100.adjusted)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .white
        return cv
    }()
    
    private let btAddCategory: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(named: "ic_plus"), for: .normal)
        bt.setTitle(Translate.Shared.create_category(), for: .normal)
        bt.titleLabel?.font = Constants.Fonts.regular16
        bt.titleLabel?.textAlignment = .center
        bt.setTitleColor(.blue, for: .normal)
        bt.backgroundColor = Constants.Colors.color222222.withAlphaComponent(0.08)
        bt.layer.masksToBounds = true
        bt.layer.cornerRadius = 16.adjusted
        return bt
    }()
    
    var rightBarButtonItem = UIBarButtonItem()
    
    var shouldEdit: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryServices = CategoryServices()
        categoryViewModel = CategoryViewModel(categoryServices.getAllItem())
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if categoryViewModel.getNumberOfCategories() < 1 {
            cvCategories.isHidden = true
            btAddCategory.isHidden = false
        } else {
            cvCategories.isHidden = false
            btAddCategory.isHidden = true
        }
    }
    
    @objc func tappedEdit() {
        if shouldEdit {
            rightBarButtonItem.title = Translate.Shared.edit()
        } else {
            rightBarButtonItem.title = Translate.Shared.done()
            if categoryViewModel.getNumberOfCategories() < 1 {
                tappedCreateCategory()
            }
        }
        shouldEdit = !shouldEdit
    }
    
    @objc func tappedCreateCategory() {
        let vc = CreateCategoryViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.title = Translate.Shared.create_category()
        vc.type = .Create
        vc.addCategory = { [weak self] item in
            self?.categoryViewModel.addNewItem(item)
            self?.cvCategories.reloadData()
            self?.cvCategories.isHidden = false
            self?.btAddCategory.isHidden = true
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

private extension CategoryViewController {
    
    func setupViews() {
        configureView()
        setupNavigation()
        setupCollectionViewCategory()
        setupButtonAddCategory()
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
    
    func setupButtonAddCategory() {
        view.addSubview(btAddCategory)
        btAddCategory.addTarget(self, action: #selector(tappedCreateCategory), for: .touchUpInside)
        NSLayoutConstraint.activate([
            btAddCategory.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btAddCategory.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btAddCategory.heightAnchor.constraint(equalToConstant: 250.adjusted),
            btAddCategory.widthAnchor.constraint(equalToConstant: view.bounds.width - (50 * 2))
        ])
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
        let category = categoryServices.getImageLocal(data)
        cell.configureCell(category)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if shouldEdit {
            let alert = UIAlertController(title: categoryViewModel.getItem(indexPath.row).name, message: Translate.Shared.would_you_like_to_choise_some_options_edit() , preferredStyle: .actionSheet)
            let create = UIAlertAction(title: Translate.Shared.create_category(), style: .default, handler: { (action) -> Void in
                self.tappedCreateCategory()
            })
            
            let edit = UIAlertAction(title: Translate.Shared.edit(), style: .default) { _ in
                let vc = CreateCategoryViewController()
                vc.hidesBottomBarWhenPushed = true
                vc.title = Translate.Shared.edit()
                vc.type = .Edit
                vc.category = self.categoryViewModel.getItem(indexPath.row)
                vc.addCategory = { [weak self] item in
                    self?.categoryViewModel.editItem(indexPath.row, item)
                    self?.cvCategories.reloadItems(at: [indexPath])
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            let delete = UIAlertAction(title: Translate.Shared.delete(), style: .default) { _ in
                self.categoryServices.delete(self.categoryViewModel.getItem(indexPath.row))
                self.categoryViewModel.deleteItem(indexPath.row)
                self.cvCategories.reloadData()
                if self.categoryViewModel.getNumberOfCategories() < 1 {
                    self.cvCategories.isHidden = true
                    self.btAddCategory.isHidden = false
                } else {
                    self.cvCategories.isHidden = false
                    self.btAddCategory.isHidden = true
                }
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

