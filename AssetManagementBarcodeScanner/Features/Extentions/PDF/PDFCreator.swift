//
//  PDFCreator.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/29/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit
import PDFKit

class PDFCreator: NSObject {
    var assetDetail: AssetDetailModel
    var imageAsset: UIImage?
    var imageQRCode: UIImage?
    var imageBarCode: UIImage?
    
    init( _ item : AssetDetailModel, _ imageAsset: UIImage?, _ imageBarCode: UIImage?, _ imageQRCode: UIImage?) {
        self.assetDetail = item
        self.imageAsset = imageAsset
        self.imageQRCode = imageQRCode
        self.imageBarCode = imageBarCode
    }
}

extension PDFCreator {
    func createAssetDetail() -> Data {
        // 1
        let pdfMetaData = [
            kCGPDFContextCreator: assetDetail.name,
            kCGPDFContextAuthor: "Nguyen Tran",
            kCGPDFContextTitle: "Asset Detail: \(assetDetail.name)"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        // 2
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        // 3
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        // 4
        let data = renderer.pdfData { (context) in
            // 5
            context.beginPage()
            // 6
            let titleBottom = addTitle(pageRect: pageRect)
            var imageAssetBottom: CGFloat = 0
            var imageBarCodeBottom: CGFloat = 0
            var imageQRCodeBottom: CGFloat = 0
            if let image = imageAsset {
                let imageBottom = addImage(pageRect: pageRect, imageTop: titleBottom + 18.0, image: image)
                imageAssetBottom = imageBottom
                addBodyText(pageRect: pageRect, textTop: imageAssetBottom + 18.0)
            }
            if let image = imageBarCode {
                let imageBottom = addImage(pageRect: pageRect, imageTop: imageAssetBottom  + 18.0, image: image)
                imageBarCodeBottom = imageBottom
                addBodyText(pageRect: pageRect, textTop: imageBarCodeBottom + 18.0)
            }
            
            if let image = imageQRCode {
                let imageBottom = addImage(pageRect: pageRect, imageTop: imageQRCodeBottom + 18.0, image: image)
                imageQRCodeBottom = imageBottom
                addBodyText(pageRect: pageRect, textTop: imageQRCodeBottom + 18.0)
            }
        }
        
        return data
    }
    
    func addTitle(pageRect: CGRect) -> CGFloat {
        // 1
        let titleFont = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        // 2
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(string: "Asset Detail: \(assetDetail.name)", attributes: titleAttributes)
        // 3
        let titleStringSize = attributedTitle.size()
        // 4
        let titleStringRect = CGRect(x: (pageRect.width - titleStringSize.width) / 2.0,
                                     y: 36, width: titleStringSize.width,
                                     height: titleStringSize.height)
        // 5
        attributedTitle.draw(in: titleStringRect)
        // 6
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addBodyText(pageRect: CGRect, textTop: CGFloat) {
        // 1
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        // 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        // 3
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "\(assetDetail.name)", attributes: textAttributes)
        // 4
        let textRect = CGRect(x: 10, y: textTop, width: pageRect.width - 20,
                              height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textRect)
    }
    
    func addImage(pageRect: CGRect, imageTop: CGFloat, image: UIImage) -> CGFloat {
        // 1
        let maxHeight = pageRect.height * 0.4
        let maxWidth = pageRect.width * 0.8
        // 2
        let aspectWidth = maxWidth / image.size.width
        let aspectHeight = maxHeight / image.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)
        // 3
        let scaledWidth = image.size.width * aspectRatio
        let scaledHeight = image.size.height * aspectRatio
        // 4
        let imageX = (pageRect.width - scaledWidth) / 2.0
        let imageRect = CGRect(x: imageX, y: imageTop,
                               width: scaledWidth, height: scaledHeight)
        // 5
        image.draw(in: imageRect)
        return imageRect.origin.y + imageRect.size.height
    }
    
}
