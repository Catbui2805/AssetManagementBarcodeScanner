//
//  HomeViewController.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/21/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var lb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "demo scanner"
        lb.font = .systemFont(ofSize: 32)
        lb.textAlignment = .center
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()

    }

}

private extension HomeViewController {
    func setupViews() {
        setupLabel()
    }
    
    func setupLabel() {
        view.addSubview(lb)
        NSLayoutConstraint.activate([
            lb.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            lb.heightAnchor.constraint(equalToConstant: 50),
            lb.widthAnchor.constraint(equalToConstant: view.bounds.width),
            lb.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
