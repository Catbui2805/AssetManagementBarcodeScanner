//
//  CategoryCell.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/24/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier: String = "CategoryCell"
    
    private let imageViewContent:  UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 6.adjusted
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "ic_pc_color")
        return iv
    }()
    
    private let lbTitle: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Constants.Fonts.regular14
        lb.textColor = Constants.Colors.color222222
        lb.numberOfLines = 2
        lb.text = "title category"
        lb.textAlignment = .center
        return lb
    }()
    
    private let imageViewSeleted: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 6.adjusted
        iv.image = UIImage(named: "ic_sort")
        iv.backgroundColor = Constants.Colors.color222222.withAlphaComponent(0.2)
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ data: CategoryModel) {
        lbTitle.text = data.name
        
        imageViewContent.image = ImageLocalManger.shared.getItem(.ImageCateogry, data.image)
        
        if data.isSelected {
            imageViewSeleted.isHidden = false
        } else {
            imageViewSeleted.isHidden = true
        }
    }
    
}

private extension CategoryCell {
    func setupViews() {
        setupImageViewContent()
        setupLabelTitle()
        setupImageViewSelected()
    }
    
    func setupImageViewContent() {
        addSubview(imageViewContent)
        NSLayoutConstraint.activate([
            imageViewContent.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.adjusted),
            imageViewContent.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.adjusted),
            imageViewContent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.adjusted),
            imageViewContent.heightAnchor.constraint(equalToConstant: 80.adjusted),
            imageViewContent.widthAnchor.constraint(equalToConstant: 80.adjusted)
        ])
    }
    
    func setupLabelTitle() {
        addSubview(lbTitle)
        NSLayoutConstraint.activate([
            lbTitle.topAnchor.constraint(equalTo: imageViewContent.bottomAnchor, constant: 4.adjusted),
            lbTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.adjusted),
            lbTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.adjusted),
            lbTitle.heightAnchor.constraint(lessThanOrEqualToConstant: 36.adjusted)
        ])
    }
    
    func setupImageViewSelected() {
        addSubview(imageViewSeleted)
        NSLayoutConstraint.activate([
            imageViewSeleted.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.adjusted),
            imageViewSeleted.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.adjusted),
            imageViewSeleted.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.adjusted),
            imageViewSeleted.heightAnchor.constraint(equalToConstant: 80.adjusted),
            imageViewSeleted.widthAnchor.constraint(equalToConstant: 80.adjusted)
        ])
    }
}
