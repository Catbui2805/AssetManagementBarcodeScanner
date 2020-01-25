//
//  CreateCategoryViewController.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/24/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Realm
import RealmSwift

enum CategoryType {
    case Create
    case Edit
}

class CreateCategoryViewController: UIViewController {
    
    private let ivIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 6.adjusted
        iv.image = UIImage(named: "ic_folder")
        return iv
    }()
    
    private let btAddImage: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle(Translate.Shared.add_image(), for: .normal)
        bt.setImage(UIImage(named: "ic_plus"), for: .normal)
        bt.titleLabel?.font = Constants.Fonts.regular16
        bt.titleLabel?.textColor = .blue
        bt.setTitleColor(.blue, for: .normal)
        return bt
    }()
    
    private let tfTitle: SkyFloatingLabelTextField = {
        let tf = SkyFloatingLabelTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = Translate.Shared.name_category()
        tf.title = Translate.Shared.name_category()
        tf.errorColor = .red
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    var category: CategoryModel?
    var type: CategoryType = .Create
    var addCategory: ((CategoryModel) -> Void)?
        
    private var categoryServices: CategoryImageSeviceable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryServices = CategoryServices()
        setupViews()
        
        if type == .Edit {
            tfTitle.text = category?.name
            ivIcon.image = category?.imageData == nil ? UIImage(named: category?.image ?? "") : category?.imageData 
        }
        
    }
    
    @objc func tappedToSave() {
        if let textTitle = tfTitle.text, textTitle.isEmpty {
            tfTitle.errorMessage = Translate.Shared.please_enter_name_category()
            return
        } else {
            
            let uuid = category?.uuid ?? UUID().uuidString
            let categoryModel = CategoryModel(uuid, tfTitle.text ?? "not content", uuid, ivIcon.image , false)
            
            addCategory?(categoryModel)
            navigationController?.popViewController(animated: true)
            
            if type == .Edit {
                categoryServices.updateImageLocal(categoryModel)
            } else {
                categoryServices.saveImageLocal(categoryModel)
            }
            
//            let realm = try! Realm()
//            try! realm.write {
//                realm.add(categoryModel)
//            }
        }
    }
    
    @objc func textFieldDidChange(_ textfield: UITextField) {
        if let text = textfield.text {
            let floatingLabelTextField = tfTitle
            if(text.count < 4) {
                floatingLabelTextField.errorMessage = Translate.Shared.please_enter_name_category()
            }
            else {
                floatingLabelTextField.errorMessage = ""
            }
        }
    }
    
    @objc func tappedAddImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension CreateCategoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        ivIcon.image = image
    }
}

private extension CreateCategoryViewController {
    func setupViews() {
        view.backgroundColor = .white
        setupImageViewIcon()
        setupNavigation()
        setupTextFieldTitle()
        setupButtonAddImage()
    }
    
    func setupNavigation() {
        let rightButton = UIBarButtonItem(title: Translate.Shared.save(), style: .plain, target: self, action: #selector(tappedToSave))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    
    func setupImageViewIcon() {
        view.addSubview(ivIcon)
        NSLayoutConstraint.activate([
            ivIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.adjusted),
            ivIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.adjusted),
            ivIcon.heightAnchor.constraint(equalToConstant: 80.adjusted),
            ivIcon.widthAnchor.constraint(equalToConstant: 80.adjusted)
        ])
    }
    
    func setupTextFieldTitle() {
        view.addSubview(tfTitle)
        NSLayoutConstraint.activate([
            tfTitle.topAnchor.constraint(equalTo: ivIcon.bottomAnchor, constant: 60.adjusted),
            tfTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.adjusted),
            tfTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.adjusted)
        ])
    }
    
    func setupButtonAddImage() {
        view.addSubview(btAddImage)
        btAddImage.addTarget(self, action: #selector(tappedAddImage), for: .touchUpInside)
        btAddImage.contentEdgeInsets = .init(top: 80.adjusted, left: 0, bottom: 0, right: 0)
        NSLayoutConstraint.activate([
            btAddImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.adjusted),
            btAddImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.adjusted),
            btAddImage.heightAnchor.constraint(equalToConstant: 120.adjusted),
            btAddImage.widthAnchor.constraint(equalToConstant: 140.adjusted)
        ])
    }
    
}
