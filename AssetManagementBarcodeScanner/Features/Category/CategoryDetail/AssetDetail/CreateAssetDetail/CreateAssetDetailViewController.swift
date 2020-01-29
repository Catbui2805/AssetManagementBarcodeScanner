//
//  CreateAssetDetailViewController.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/26/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import RealmSwift
import Realm

class CreateAssetDetailViewController: UIViewController {
    
    static let identifier: String = "CreateAssetDetailViewController"
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private var stackView: UIStackView!
    
    private let ivAsset: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 6.adjusted
        iv.image = UIImage(named: "ic_folder")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let btAddImage: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle(Translate.Shared.add_image(), for: .normal)
        bt.titleLabel?.font = Constants.Fonts.regular16
        bt.titleLabel?.textColor = .blue
        bt.setTitleColor(.blue, for: .normal)
        return bt
    }()
    
    let tfName: SkyFloatingLabelTextField = {
        let tf = SkyFloatingLabelTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = Translate.Shared.name_category()
        tf.title = Translate.Shared.name_category()
        tf.errorColor = .red
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 6.adjusted
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    let tfLabel: SkyFloatingLabelTextField = {
        let tf = SkyFloatingLabelTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Label"
        tf.title = "Label"
        return tf
    }()
    
    
    let tfSeriNumber: SkyFloatingLabelTextField = {
        let tf = SkyFloatingLabelTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Seri number"
        tf.title = "Seri number"
        tf.errorColor = .red
        tf.clipsToBounds = true
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    let tfAssetStatus: SkyFloatingLabelTextField = {
        let tf = SkyFloatingLabelTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.title = "Asset status"
        tf.text = AssetStatus.NORMAL.name()
        tf.placeholder = "Asset status"
        tf.clipsToBounds = true
//        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    let tfNote: SkyFloatingLabelTextField = {
        let tf = SkyFloatingLabelTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Notes"
        tf.title = "Notes"
        tf.clipsToBounds = true
        return tf
    }()
    
    let tfPrice: SkyFloatingLabelTextField = {
        let tf = SkyFloatingLabelTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Price"
        tf.title = "Price"
        tf.text = "0.0"
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let tfDatePurchase: SkyFloatingLabelTextField = {
        let tf = SkyFloatingLabelTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Date purchase"
        tf.title = "Date purchase"
        tf.text = "\(Date().toString(dateFormat: Constants.Strings.dateFormat))"
//        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    let tfDateUpdate: SkyFloatingLabelTextField = {
        let tf = SkyFloatingLabelTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Date update"
        tf.title = "Date update"
        tf.text = "\(Date().toString(dateFormat: Constants.Strings.dateFormat))"
//        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    private var ivBarCode: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 0.adjusted
        iv.image = UIImage(named: "ic_bar_default")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let ivQRCode: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 0.adjusted
        iv.image = UIImage(named: "ic_qr_default")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let lbBarCode = UILabel(frame: CGRect(x: 0, y: 0, width: Constants.Screen.screenWidth, height: 44))
    
    let lbQRCode = UILabel(frame: CGRect(x: 0, y: 0, width: Constants.Screen.screenWidth, height: 44))
    
    var rightBarButtonItem = UIBarButtonItem()
    
    
    var uuidAsset: String = String(UUID().uuidString.prefix(8))
    var type: CRUDType = .Create
    var assetDetailModelCurrent: ((AssetDetailModel) -> Void)?
    var assetDetailModelOld: AssetDetailModel?
    var categoryModel: CategoryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        tfName.resignFirstResponder()
        tfSeriNumber.resignFirstResponder()
        tfNote.resignFirstResponder()
        tfLabel.resignFirstResponder()
        tfPrice.resignFirstResponder()
    }
    
    @objc func textFieldDidChange(_ textfield: SkyFloatingLabelTextField) {
        if let text = textfield.text {
            let floatingLabelTextField = textfield
            if(text.count < 4) {
                floatingLabelTextField.errorMessage = Translate.Shared.please_enter_name_category()
            }
            else {
                floatingLabelTextField.errorMessage = ""
            }
        }
    }
    
    @objc func tappedToSave() {
        guard let name = tfName.text, !(tfName.text?.isEmpty ?? true) else {
            tfName.errorMessage = "Please input name"
            tfName.becomeFirstResponder()
            return
        }
        guard let seriNumber = tfSeriNumber.text, !(tfSeriNumber.text?.isEmpty ?? true) else {
            tfSeriNumber.errorMessage = "Please input seri number"
            tfSeriNumber.becomeFirstResponder()
            return
        }
        
        let realm = try! Realm()
        let uuid = assetDetailModelOld?.uuid ?? uuidAsset
        let assetDetailModel = AssetDetailModel(uuid, name, tfLabel.text ?? "", seriNumber,
                                                tfAssetStatus.text ?? AssetStatus.NORMAL.name(),
                                                tfNote.text ?? "", uuid, uuid, uuid, Date(),
                                                Double(tfPrice.text ?? "0")!, Date())
        guard let object = categoryModel else {
            return
        }
        if type == .Update {
            try! realm.write {
                realm.add(assetDetailModel, update: .all)
                object.assets.append(assetDetailModel)
            }
        } else {
            try! realm.write {
                realm.add(assetDetailModel, update: .error)
                object.assets.append(assetDetailModel)
            }
        }
        if let image = ivAsset.image {
            ImageLocalManger.shared.save(.ImageAssets, uuid, image)
        }
        assetDetailModelCurrent?(assetDetailModel)
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func tappedAddImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true)
    }
    
    @objc func btShareAction() {
        guard let item = assetDetailModelOld else { return }
        let pdfCreator = PDFCreator(item, ivAsset.image, ivBarCode.image, ivQRCode.image)
        let pdfData = pdfCreator.createAssetDetail()
        let vc = UIActivityViewController(activityItems: [pdfData], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
}


// MARK:  Setup Views

private extension CreateAssetDetailViewController {
    func setupViews() {
        view.backgroundColor = .white
        setupScrollView()
        setupStackViewContent()
        setupViewContent()
        setupTextFields()
        setupNavigation()
        preConditionsView()
    }
    
    func preConditionsView() {
        switch type {
        case .Create: break
            
        case .Read:
            tfName.text = assetDetailModelOld?.name ?? ""
            tfName.textColor = Constants.Colors.color222222
            
            tfLabel.text = assetDetailModelOld?.label ?? ""
            tfLabel.textColor = Constants.Colors.color222222
            
            tfAssetStatus.text = assetDetailModelOld?.assetStatus ?? ""
            tfAssetStatus.textColor = Constants.Colors.color222222
            
            tfSeriNumber.text = assetDetailModelOld?.seriNumber ?? ""
            tfSeriNumber.textColor = Constants.Colors.color222222
            
            tfPrice.text = "\(String(describing: assetDetailModelOld?.price ?? 0.0))"
            tfPrice.textColor = Constants.Colors.color222222
            
            tfNote.text = assetDetailModelOld?.note ?? ""
            tfNote.textColor = Constants.Colors.color222222
            
            tfDateUpdate.text = assetDetailModelOld?.dateUpdate.toString(dateFormat: Constants.Strings.dateFormat)
            tfDateUpdate.textColor = Constants.Colors.color222222
            
            tfDatePurchase.text = assetDetailModelOld?.dateOfPurchase.toString(dateFormat: Constants.Strings.dateFormat)
            tfDatePurchase.textColor = Constants.Colors.color222222
            
            uuidAsset = assetDetailModelOld?.uuid ?? ""
            ivAsset.image = ImageLocalManger.shared.getItem(.ImageAssets, assetDetailModelOld?.imageAsset ?? "")
            btAddImage.setTitle("", for: .normal)
            
            stackView.isUserInteractionEnabled = false
            
        case .Update:
            tfName.text = assetDetailModelOld?.name ?? ""
            tfLabel.text = assetDetailModelOld?.label ?? ""
            tfAssetStatus.text = assetDetailModelOld?.assetStatus ?? ""
            tfSeriNumber.text = assetDetailModelOld?.seriNumber ?? ""
            tfPrice.text = "\(String(describing: assetDetailModelOld?.price ?? 0.0))"
            tfNote.text = assetDetailModelOld?.note ?? ""
            tfDateUpdate.text = assetDetailModelOld?.dateUpdate.toString(dateFormat: Constants.Strings.dateFormat)
            tfDatePurchase.text = assetDetailModelOld?.dateOfPurchase.toString(dateFormat: Constants.Strings.dateFormat)
            uuidAsset = assetDetailModelOld?.uuid ?? ""
            ivAsset.image = ImageLocalManger.shared.getItem(.ImageAssets, assetDetailModelOld?.imageAsset ?? "")
            
        case .Delete: break
        }
        
        lbBarCode.text = uuidAsset
        lbQRCode.text = uuidAsset
        ivBarCode.image = generateBarcode(from: uuidAsset)
        ivQRCode.image = generateQRCode(from: uuidAsset)
    }
    
    func setupNavigation() {
        switch type {
        case .Read:
            title = type.name()
            rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(btShareAction))
        default:
            title = type.name()
            rightBarButtonItem = UIBarButtonItem(title: Translate.Shared.save(), style: .plain, target: self, action: #selector(tappedToSave))
        }
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.keyboardDismissMode = .interactive
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        scrollView.addGestureRecognizer(tapGesture)
        scrollView.contentInset = .init(top: 40.adjusted, left: 0, bottom: 40.adjusted, right: 0)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func setupStackViewContent() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 16.adjusted
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        stackView.addGestureRecognizer(tapGesture)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setupViewContent() {
        setupImageViewAsset()
        setupTextFieldName()
        setupTextFieldLabel()
        setupTextFieldSeriNumber()
        setupTextFieldAssetStatus()
        setupTextFieldNote()
        setupTextFieldPrice()
        setupTextFieldDatePurchase()
        setupTextFieldDateUpdate()
        setupImageViewBarCode()
        setupImageViewQRcode()
    }
    
    func setupImageViewAsset() {
        let viewImageAsset = UIView()
        stackView.addArrangedSubview(viewImageAsset)
        btAddImage.addTarget(self, action: #selector(tappedAddImage), for: .touchUpInside)
        btAddImage.contentEdgeInsets = .init(top: 150.adjusted, left: 0, bottom: 0, right: 0)
        viewImageAsset.translatesAutoresizingMaskIntoConstraints = false
        viewImageAsset.addSubview(ivAsset)
        viewImageAsset.addSubview(btAddImage)
        NSLayoutConstraint.activate([
            viewImageAsset.heightAnchor.constraint(equalToConstant: 160.adjusted),
            btAddImage.centerXAnchor.constraint(equalTo: viewImageAsset.centerXAnchor),
            btAddImage.topAnchor.constraint(equalTo: viewImageAsset.topAnchor),
            btAddImage.heightAnchor.constraint(equalTo: viewImageAsset.heightAnchor),
            btAddImage.widthAnchor.constraint(equalTo: ivAsset.widthAnchor),
            
            ivAsset.topAnchor.constraint(equalTo: viewImageAsset.topAnchor),
            ivAsset.centerXAnchor.constraint(equalTo: viewImageAsset.centerXAnchor),
            ivAsset.heightAnchor.constraint(equalToConstant: 140.adjusted),
            ivAsset.widthAnchor.constraint(equalToConstant: 140.adjusted)
        ])
    }
    
    func setupTextFieldName() {
        stackView.addArrangedSubview(tfName)
        NSLayoutConstraint.activate([
            tfName.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30.adjusted),
            tfName.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30.adjusted),
            tfName.heightAnchor.constraint(equalToConstant: 50.adjusted)
        ])
    }
    
    func setupTextFieldLabel() {
        stackView.addArrangedSubview(tfLabel)
        NSLayoutConstraint.activate([
            tfLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30.adjusted),
            tfLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30.adjusted),
            tfLabel.heightAnchor.constraint(equalToConstant: 50.adjusted)
        ])

    }
    
    func setupTextFieldSeriNumber() {
        stackView.addArrangedSubview(tfSeriNumber)
        NSLayoutConstraint.activate([
            tfSeriNumber.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30.adjusted),
            tfSeriNumber.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30.adjusted),
            tfSeriNumber.heightAnchor.constraint(equalToConstant: 50.adjusted)
        ])
    }
    
    func setupTextFieldAssetStatus() {
        stackView.addArrangedSubview(tfAssetStatus)
        NSLayoutConstraint.activate([
            tfAssetStatus.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30.adjusted),
            tfAssetStatus.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30.adjusted),
            tfAssetStatus.heightAnchor.constraint(equalToConstant: 50.adjusted)
        ])
    }
    
    func setupTextFieldNote() {
        stackView.addArrangedSubview(tfNote)
        NSLayoutConstraint.activate([
            tfNote.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30.adjusted),
            tfNote.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30.adjusted),
            tfNote.heightAnchor.constraint(equalToConstant: 50.adjusted)
        ])
    }
    
    func setupTextFieldPrice() {
        stackView.addArrangedSubview(tfPrice)
        NSLayoutConstraint.activate([
            tfPrice.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30.adjusted),
            tfPrice.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30.adjusted),
            tfPrice.heightAnchor.constraint(equalToConstant: 50.adjusted)
        ])

    }
    
    func setupTextFieldDatePurchase() {
        stackView.addArrangedSubview(tfDatePurchase)
        NSLayoutConstraint.activate([
            tfDatePurchase.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30.adjusted),
            tfDatePurchase.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30.adjusted),
            tfDatePurchase.heightAnchor.constraint(equalToConstant: 50.adjusted)
        ])

    }
    
    func setupTextFieldDateUpdate() {
        stackView.addArrangedSubview(tfDateUpdate)
        NSLayoutConstraint.activate([
            tfDateUpdate.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30.adjusted),
            tfDateUpdate.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30.adjusted),
            tfDateUpdate.heightAnchor.constraint(equalToConstant: 50.adjusted)
        ])
    }
    
    func setupImageViewBarCode() {
        stackView.addArrangedSubview(ivBarCode)
        lbBarCode.textAlignment = .center
        lbBarCode.numberOfLines = 0
        stackView.addArrangedSubview(lbBarCode)
        
        NSLayoutConstraint.activate([
            ivBarCode.heightAnchor.constraint(equalToConstant: 100.adjusted),
            ivBarCode.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 40.adjusted),
            ivBarCode.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -40.adjusted)
            
        ])
    }
    
    func setupImageViewQRcode() {
        stackView.addArrangedSubview(ivQRCode)
        lbQRCode.textAlignment = .center
        lbQRCode.numberOfLines = 0
        stackView.addArrangedSubview(lbQRCode)
        NSLayoutConstraint.activate([
            ivBarCode.heightAnchor.constraint(equalToConstant: 100.adjusted),
            ivBarCode.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 40.adjusted),
            ivBarCode.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -40.adjusted)
        ])
    }
    
}


// MARK:  Generate Qr code and Bar code

private extension CreateAssetDetailViewController {
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}


// MARK:  Setup button on keyboard

private extension CreateAssetDetailViewController {
    func setupTextFields() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30.adjusted)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        
        let saveButton = UIBarButtonItem(title: Translate.Shared.save(),
                                         style: .done, target: self, action: #selector(tappedToSave))
        toolbar.setItems([flexSpace, saveButton], animated: false)
        toolbar.sizeToFit()
        
        tfName.inputAccessoryView = toolbar
        tfNote.inputAccessoryView = toolbar
        tfLabel.inputAccessoryView = toolbar
        tfPrice.inputAccessoryView = toolbar
        tfSeriNumber.inputAccessoryView = toolbar
        
    }
}

// MARK:  Get image from library

extension CreateAssetDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        ivAsset.image = image
    }
}
