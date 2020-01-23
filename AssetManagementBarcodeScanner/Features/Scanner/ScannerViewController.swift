//
//  ScannerViewController.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit

class ScannerViewController: UIViewController {

    static let identifier: String = "ScannerViewController"
    
      var lb: UILabel = {
            let lb = UILabel()
            lb.translatesAutoresizingMaskIntoConstraints = false
            lb.text = "Scanner"
            lb.font = .systemFont(ofSize: 32)
            lb.textAlignment = .center
            return lb
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.addSubview(lb)
            NSLayoutConstraint.activate([
                lb.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                lb.heightAnchor.constraint(equalToConstant: 50),
                lb.widthAnchor.constraint(equalToConstant: view.bounds.width),
                lb.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            ])
            
        }
    }
