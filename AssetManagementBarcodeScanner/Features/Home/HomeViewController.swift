//
//  HomeViewController.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/21/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    static let identifier = "HomeViewController"
    
    var lb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "demo scanner"
        lb.font = .systemFont(ofSize: 32)
        lb.textAlignment = .center
        return lb
    }()
    
    var btQrScanner: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = .blue
        bt.setTitle("QR Scanner", for: .normal)
        bt.titleLabel?.textColor = .white
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    @objc func tappedQRScanner() {
        let vc = CreateAssetDetailViewController()        
//        let vc = QRScannerViewController()
//        vc.title = "Scanner"
        navigationController?.pushViewController(vc, animated: true)
        
//        // MARK:  generator QR code
//        let vc = GeneratorQRCodeViewController()
//        navigationController?.pushViewController(vc, animated: true)

    }
}

private extension HomeViewController {
    func setupViews() {
        setupLabel()
        setupButtonQRScanner()
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
    
    func setupButtonQRScanner() {
        view.addSubview(btQrScanner)
        btQrScanner.addTarget(self, action: #selector(tappedQRScanner), for: .touchUpInside)
        NSLayoutConstraint.activate([
            btQrScanner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btQrScanner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btQrScanner.heightAnchor.constraint(equalToConstant: 44),
            btQrScanner.widthAnchor.constraint(equalToConstant: view.bounds.width - (60 * 2))
        ])
    }
}

