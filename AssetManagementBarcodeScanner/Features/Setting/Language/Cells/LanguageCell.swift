//
//  LanguageCell.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/24/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit

class LanguageCell: UICollectionViewCell {
    static let identifier: String = "LanguageCell"
    
    let lbName: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Constants.Fonts.settingTitleCell
        lb.textColor = Constants.Colors.settingTitleCell
        return lb
    }()
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "ic_sort")
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
    
    func configureCell(_ data: LanguageModel) {
        lbName.text = data.name
        if data.isSelected {
            imageView.isHidden = false
        } else {
            imageView.isHidden = true
        }
    }
    
}

private extension LanguageCell {
    func setupViews() {
        setupLabelName()
        setupImageView()
        setupViewLine()
    }
    
    func setupLabelName() {
        addSubview(lbName)
        NSLayoutConstraint.activate([
            lbName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 26.adjusted),
            lbName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            lbName.heightAnchor.constraint(equalToConstant: 20.adjusted),
            lbName.widthAnchor.constraint(lessThanOrEqualToConstant: self.bounds.width / 2)
        ])
    }
    
    func setupImageView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.adjusted),
            imageView.heightAnchor.constraint(equalToConstant: 20.adjusted),
            imageView.widthAnchor.constraint(equalToConstant: 20.adjusted),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setupViewLine() {
        addSubview(line)
        NSLayoutConstraint.activate([
            line.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.adjusted),
            line.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.adjusted),
            line.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16.adjusted),
            line.heightAnchor.constraint(equalToConstant: 0.5.adjusted)
        ])
    }
    
}
