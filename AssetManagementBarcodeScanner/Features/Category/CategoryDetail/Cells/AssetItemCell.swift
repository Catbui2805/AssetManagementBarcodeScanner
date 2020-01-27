//
//  AssetItemCell.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/27/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit

class AssetItemCell: UICollectionViewCell {
    
    static let identifier: String = "AssetItemCell"
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 6.adjusted
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let lbNameItem: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Constants.Fonts.semibold16
        lb.textColor = Constants.Colors.color222222
        return lb
    }()
    
    let lbStatusItem: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Constants.Fonts.regular12
        lb.textColor = Constants.Colors.color777878
        return lb
    }()
    
    let lbNameOwner: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = Constants.Colors.color777878
        lb.font = Constants.Fonts.regular12
        lb.text = "Nhân viên F99"
        return lb
    }()
    
    let lbdDateUpdate: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = Constants.Colors.color777878
        lb.font = Constants.Fonts.regular12
        return lb
    }()
    
    let btAddToCart: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    let ivAddToCart: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "ic_add_to_cart"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let colorStatus: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .blue
        return v
    }()
    
    let lineBottom: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = Constants.Colors.colorLine
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell( _ item: AssetDetailModel) {
        imageView.image = ImageLocalManger.shared.getItem(.ImageAssets, item.imageAsset)
        lbNameItem.text = item.name
        lbStatusItem.text =  item.assetStatus
        lbdDateUpdate.text = item.dateUpdate.toString(dateFormat: "dd-MM-yyyy")
    }
}

// MARK:  Setup views
private extension AssetItemCell {
    func setupViews() {
        backgroundColor = .white
        setupImageView()
        setupViewColorStatus()
        setupLabelNameItem()
        setupLabelStatusItem()
        setupLabelNameOwner()
        setupLabelDateUpdate()
        
        setupViewLineBottom()
    }
    
    func setupImageView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 17.adjusted),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.adjusted),
            imageView.heightAnchor.constraint(equalToConstant: 100.adjusted),
            imageView.widthAnchor.constraint(equalToConstant: 100.adjusted)
        ])
    }
    
    func setupViewColorStatus() {
        addSubview(colorStatus)
        NSLayoutConstraint.activate([
            colorStatus.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.adjusted),
            colorStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.adjusted),
            colorStatus.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.adjusted),
            colorStatus.widthAnchor.constraint(equalToConstant: 10.adjusted)
        ])
    }
    
    func setupLabelNameItem() {
           addSubview(lbNameItem)
           NSLayoutConstraint.activate([
               lbNameItem.topAnchor.constraint(equalTo: self.topAnchor, constant: 17.adjusted),
               lbNameItem.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16.adjusted),
               lbNameItem.trailingAnchor.constraint(equalTo: colorStatus.leadingAnchor, constant: -8.adjusted),
               lbNameItem.heightAnchor.constraint(lessThanOrEqualToConstant: 30.adjusted)
           ])
       }
    
    func setupLabelStatusItem() {
        addSubview(lbStatusItem)
        NSLayoutConstraint.activate([
            lbStatusItem.topAnchor.constraint(equalTo: lbNameItem.bottomAnchor, constant: 4.adjusted),
            lbStatusItem.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16.adjusted),
            lbStatusItem.trailingAnchor.constraint(equalTo: colorStatus.leadingAnchor, constant: -8),
            lbStatusItem.heightAnchor.constraint(equalToConstant: 20.adjusted)
        ])
    }
    
    func setupLabelNameOwner() {
        addSubview(lbNameOwner)
        NSLayoutConstraint.activate([
            lbNameOwner.topAnchor.constraint(equalTo: lbStatusItem.bottomAnchor, constant: 4.adjusted),
            lbNameOwner.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16.adjusted),
            lbNameOwner.trailingAnchor.constraint(equalTo: colorStatus.leadingAnchor, constant: -8),
            lbNameOwner.heightAnchor.constraint(equalToConstant: 20.adjusted)
        ])
    }
    
    func setupLabelDateUpdate() {
        addSubview(lbdDateUpdate)
        NSLayoutConstraint.activate([
            lbdDateUpdate.topAnchor.constraint(equalTo: lbNameOwner.bottomAnchor, constant: 4.adjusted),
            lbdDateUpdate.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16.adjusted),
            lbdDateUpdate.trailingAnchor.constraint(equalTo: colorStatus.leadingAnchor, constant: -8),
            lbdDateUpdate.heightAnchor.constraint(equalToConstant: 20.adjusted)
        ])
    }
    
    func setupViewLineBottom() {
        addSubview(lineBottom)
        NSLayoutConstraint.activate([
            lineBottom.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1.adjusted),
            lineBottom.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.adjusted),
            lineBottom.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.adjusted),
            lineBottom.heightAnchor.constraint(equalToConstant: 0.5.adjusted)
        ])
    }
}

