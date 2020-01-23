//
//  SettingCell.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit

class SettingCell: UICollectionViewCell {
    
    static let identifier: String = "SettingCell"
    
    let imageIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let lbTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Constants.Fonts.settingTitleCell
        lb.textColor = Constants.Colors.settingTitleCell
        return lb
    }()
    
    let lbdesc: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Constants.Fonts.settingTitleCell
        lb.textColor = Constants.Colors.settingDescCell
        return lb
    }()
    
    let image: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "ic_chevron_right")
        return iv
    }()
    
    let line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.Colors.colorLine
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ data: SettingModel) {
        if data.image.isEmpty {
            imageIcon.isHidden = true
            lbTitle.leadingAnchor.constraint(equalTo: imageIcon.trailingAnchor, constant: -26).isActive = true
        } else {
            imageIcon.isHidden = false
            imageIcon.image = UIImage(named: data.image)
        }
        
        lbTitle.text = data.title
        
        if data.desc.isEmpty {
            lbdesc.isHidden = true
            image.isHidden = false
        } else {
            lbdesc.isHidden = false
            image.isHidden = true
            lbdesc.text = data.desc
        }
    }
}

private extension SettingCell {
    func setupViews() {
        setupImageViewIcon()
        setupLabelTitle()
        setupLabelDesc()
        setupImageView()
        setupViewLine()
    }
    
    func setupImageViewIcon() {
        addSubview(imageIcon)
        NSLayoutConstraint.activate([
            imageIcon.heightAnchor.constraint(equalToConstant: 24.adjusted),
            imageIcon.widthAnchor.constraint(equalToConstant: 24.adjusted),
            imageIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 26.adjusted)
        ])
    }
    
    func setupLabelTitle() {
        addSubview(lbTitle)
        NSLayoutConstraint.activate([
            lbTitle.leadingAnchor.constraint(equalTo: imageIcon.trailingAnchor, constant: 22.adjusted),
            lbTitle.heightAnchor.constraint(equalToConstant: 20.adjusted),
            lbTitle.widthAnchor.constraint(lessThanOrEqualToConstant: 250.adjusted),
            lbTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setupLabelDesc() {
        addSubview(lbdesc)
        NSLayoutConstraint.activate([
            lbdesc.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -28.adjusted),
            lbdesc.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            lbdesc.heightAnchor.constraint(equalToConstant: 20.adjusted),
            lbdesc.widthAnchor.constraint(lessThanOrEqualToConstant: 100.adjusted),
        ])
    }
    
    func setupImageView() {
        addSubview(image)
        NSLayoutConstraint.activate([
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -28.adjusted),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 12.adjusted),
            image.widthAnchor.constraint(lessThanOrEqualToConstant: 12.adjusted),
        ])
    }
    
    func setupViewLine() {
        addSubview(line)
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: 0.5.adjusted),
            line.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.adjusted),
            line.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.adjusted),
            line.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.adjusted)
        ])
    }
}
