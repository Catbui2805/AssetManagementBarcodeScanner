//
//  CategoryDetailViewController.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/25/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class CategoryDetailViewController: UIViewController {
    
    static let identifier: String = "CategoryDetailViewController"
    
    private let viewTop: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let lbTotal = UILabel()
    
    private let lbNumber = UILabel()
    
    private let cvAssets: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
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
    
    private var rightBarButton = UIBarButtonItem()
    
    var crudType: CRUDType = .Read
    var categoryModel: CategoryModel?
    private var categoryDetailViewModel: CategoryDetailViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryDetailViewModel = CategoryDetailViewModel(Array(categoryModel?.assets ?? List<AssetDetailModel>()))
        title = categoryModel?.name ?? Translate.Shared.category()
        setupViews()
    }
    
    @objc func tappedAddAsset() {
        let vc = CreateAssetDetailViewController()
        vc.type = .Create
        vc.categoryModel = categoryModel
        vc.assetDetailModelCurrent = { [weak self] item in
            self?.categoryDetailViewModel.addItem(item)
            self?.cvAssets.reloadData()
            self?.preConditionView()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tappedOptionAction() {
        let alert = UIAlertController(title: Translate.Shared.options(), message: Translate.Shared.would_you_like_to_choise_some_options_edit() , preferredStyle: .actionSheet)
        let create = UIAlertAction(title: Translate.Shared.create_asset(), style: .default) { _ in
            self.tappedAddAsset()
        }
        
        let read = UIAlertAction(title: Translate.Shared.read(), style: .default) { _ in
            self.crudType = .Read
        }
        
        let update = UIAlertAction(title: Translate.Shared.edit(), style: .default) { _ in
            self.crudType = .Update
        }
        
        let delete = UIAlertAction(title: Translate.Shared.delete(), style: .default) { _ in
            self.crudType = .Delete
        }
        let cancel = UIAlertAction(title: Translate.Shared.cancel(), style: .cancel, handler: nil)
        
        alert.addAction(create)
        alert.addAction(read)
        alert.addAction(update)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
}


// MARK:  Setup views
private extension CategoryDetailViewController {
    func setupViews() {
        view.backgroundColor = .white
        configRegisters()
        setupNavigation()
        setupCollectionAsset()
        setupViewTop()
        setupButtonAddCategory()
        preConditionView()
    }
    
    func configRegisters() {
        cvAssets.delegate = self
        cvAssets.dataSource = self
        cvAssets.register(AssetItemCell.self, forCellWithReuseIdentifier: AssetItemCell.identifier)
    }
    
    func setupNavigation() {
        rightBarButton = UIBarButtonItem(title: Translate.Shared.options(), style: .plain, target: self, action: #selector(tappedOptionAction))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func setupViewTop() {
        view.addSubview(viewTop)
        viewTop.backgroundColor = .white
        
        lbTotal.translatesAutoresizingMaskIntoConstraints = false
        viewTop.addSubview(lbTotal)
        lbTotal.text = "Total drieves:"
        
        lbNumber.translatesAutoresizingMaskIntoConstraints = false
        viewTop.addSubview(lbNumber)
        lbNumber.text = "\(categoryDetailViewModel.numberOfAssets())"
        lbNumber.textAlignment = .right
        
        NSLayoutConstraint.activate([
            viewTop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewTop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewTop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewTop.heightAnchor.constraint(equalToConstant: 50.adjusted),
            
            lbTotal.topAnchor.constraint(equalTo: viewTop.topAnchor),
            lbTotal.leadingAnchor.constraint(equalTo: viewTop.leadingAnchor, constant: 16.adjusted),
            lbTotal.bottomAnchor.constraint(equalTo: viewTop.bottomAnchor),
            lbTotal.widthAnchor.constraint(equalToConstant: Constants.Screen.screenWidth / 2),
            
            lbNumber.topAnchor.constraint(equalTo: viewTop.topAnchor),
            lbNumber.bottomAnchor.constraint(equalTo: viewTop.bottomAnchor),
            lbNumber.trailingAnchor.constraint(equalTo: viewTop.trailingAnchor, constant: -16.adjusted),
            lbNumber.leadingAnchor.constraint(equalTo: lbTotal.trailingAnchor)
        ])
    }
    
    func setupButtonAddCategory() {
        view.addSubview(btAddCategory)
        btAddCategory.addTarget(self, action: #selector(tappedAddAsset), for: .touchUpInside)
        NSLayoutConstraint.activate([
            btAddCategory.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btAddCategory.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btAddCategory.heightAnchor.constraint(equalToConstant: 250.adjusted),
            btAddCategory.widthAnchor.constraint(equalToConstant: view.bounds.width - (50 * 2))
        ])
    }
    
    func setupCollectionAsset() {
        view.addSubview(cvAssets)
        cvAssets.frame = view.frame
        cvAssets.contentInset = .init(top: 80.adjusted, left: 0, bottom: 40.adjusted, right: 0)
    }
    
    func preConditionView() {
        lbNumber.text = "\(categoryDetailViewModel.numberOfAssets())"
        if categoryDetailViewModel.numberOfAssets() < 1 {
            cvAssets.isHidden = true
            btAddCategory.isHidden = false
        } else {
            cvAssets.isHidden = false
            btAddCategory.isHidden = true
        }
    }
}


// MARK:  Collection view delegate, data source
extension CategoryDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryDetailViewModel.numberOfAssets()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssetItemCell.identifier, for: indexPath) as? AssetItemCell else {
            fatalError("Can't dequeue reusable cell")
        }
        let item = categoryDetailViewModel.getItem(indexPath.row)
        cell.configCell(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = categoryDetailViewModel.getItem(indexPath.row)
        
        switch crudType {
        case .Create:
            return
        case .Read:
            let vc = CreateAssetDetailViewController()
            vc.assetDetailModelOld = item
            vc.categoryModel = categoryModel
            vc.type = .Read
            navigationController?.pushViewController(vc, animated: true)
            return
        case .Update:
            let vc = CreateAssetDetailViewController()
            vc.assetDetailModelOld = item
            vc.type = .Update
            vc.categoryModel = categoryModel
            vc.assetDetailModelCurrent = { [weak self] item in
                self?.categoryDetailViewModel.editItem(indexPath.row, item)
                self?.cvAssets.reloadItems(at: [indexPath])
            }
            navigationController?.pushViewController(vc, animated: true)
        case .Delete:
            
            let alert = UIAlertController(title: Translate.Shared.delete(), message: item.name, preferredStyle: .alert)
            let delete = UIAlertAction(title: Translate.Shared.delete(), style: .destructive) { _ in
                self.categoryDetailViewModel.deleteItem(indexPath.row)
                self.cvAssets.reloadData()
                DataManager.shared.delete(item)
                self.preConditionView()
            }
            
            let cancel = UIAlertAction(title: Translate.Shared.cancel(), style: .cancel, handler: nil)
            alert.addAction(cancel)
            alert.addAction(delete)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

extension CategoryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width, height: 135.adjusted)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.adjusted
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.adjusted
    }
}

