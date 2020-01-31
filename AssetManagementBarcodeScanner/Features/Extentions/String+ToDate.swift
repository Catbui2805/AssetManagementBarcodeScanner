//
//  String+ToDate.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/30/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation

extension String {
    func toDate(withFormat format: String = Constants.Strings.dateFormat) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            preconditionFailure("Take a look to your format")
        }
        
        return date
    }
    
}

