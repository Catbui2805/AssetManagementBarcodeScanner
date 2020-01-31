//
//  ScannerViewController.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/23/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit
import AVFoundation
import Realm
import RealmSwift

enum ScannerType {
    case CHECKCODE
    case READ
    case CREATE
    case UPDATE
    case DELETE
    case SHARE
    
    func name() -> String {
        switch self {
        case .CHECKCODE:
            return "Check status asset"
        case .READ:
            return Translate.Shared.read()
        case .CREATE:
            return Translate.Shared.create()
        case .UPDATE:
            return Translate.Shared.update()
        case .DELETE:
            return Translate.Shared.delete()
        case .SHARE:
            return Translate.Shared.share()
        }
    }
}

class ScannerViewController: UIViewController {
    
    static let identifier: String = "ScannerViewController"
    
    private let messageLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 22, weight: .semibold)
        lb.textColor = .red
        lb.textAlignment = .center
        return lb
    }()
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]
    
    var scannerType: ScannerType = .CHECKCODE
    var categoryServices: CategoryServicesable!
    
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryServices = CategoryServices()
        setupViews()
        
        // Get the back-facing camera for capturing videos
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            //            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        // Start video capture.
        captureSession.startRunning()
        
        // Move the message label and top bar to the front
        view.bringSubviewToFront(messageLabel)
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView(frame: CGRect(x: 20, y: (view.bounds.height / 2) - 150, width: view.bounds.width - (20 * 2), height: 300))
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper methods
    
    func launchApp(decodedURL: String) {
        
        if presentedViewController != nil {
            return
        }
        
        // Search uuid in database
        
        
        let alert = UIAlertController(title: Translate.Shared.scanner(), message: "You're going to open \(decodedURL)", preferredStyle: .actionSheet)

        
        if let item = realm.object(ofType: AssetDetailModel.self, forPrimaryKey: decodedURL){
            let checkCode = UIAlertAction(title: "Update status asset", style: .default) { _ in
                self.scannerType = .CHECKCODE
                
                try! self.realm.write {
                    item.dateUpdate = Date()
                }
            }
            alert.addAction(checkCode)
            
            let read = UIAlertAction(title: Translate.Shared.read(), style: .default) { _ in
                self.scannerType = .READ
            }
            alert.addAction(read)
            
            let update = UIAlertAction(title: Translate.Shared.edit(), style: .default) { _ in
                self.scannerType = .UPDATE
            }
            alert.addAction(update)
            
            let delete = UIAlertAction(title: Translate.Shared.delete(), style: .default) { _ in
                self.scannerType = .DELETE
            }
            alert.addAction(delete)
            
        } else {
            let create = UIAlertAction(title: Translate.Shared.create_asset(), style: .default) { _ in
                self.scannerType = .CREATE
            }
            alert.addAction(create)
            
        }
        
        let share = UIAlertAction(title: Translate.Shared.share(), style: .default) { _ in
            self.scannerType = .SHARE
        }
        
        let cancel = UIAlertAction(title: Translate.Shared.cancel(), style: .cancel, handler: nil)
        
        alert.addAction(share)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    private func updatePreviewLayer(layer: AVCaptureConnection, orientation: AVCaptureVideoOrientation) {
        layer.videoOrientation = orientation
        videoPreviewLayer?.frame = self.view.bounds
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let connection =  self.videoPreviewLayer?.connection  {
            let currentDevice: UIDevice = UIDevice.current
            let orientation: UIDeviceOrientation = currentDevice.orientation
            let previewLayerConnection : AVCaptureConnection = connection
            
            if previewLayerConnection.isVideoOrientationSupported {
                switch (orientation) {
                case .portrait:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .portrait)
                    break
                case .landscapeRight:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .landscapeLeft)
                    break
                case .landscapeLeft:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .landscapeRight)
                    break
                case .portraitUpsideDown:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .portraitUpsideDown)
                    break
                default:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .portrait)
                    break
                }
            }
        }
    }
    
}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect(x: 20, y: (view.bounds.height / 2) - 150, width: view.bounds.width - (20 * 2), height: 300)
            
            messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                launchApp(decodedURL: metadataObj.stringValue!)
                messageLabel.text = metadataObj.stringValue
            }
        }
    }
    
}

private extension ScannerViewController {
    func setupViews() {
        setupLabelMessage()

    }
    
    func setupLabelMessage() {
        view.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
