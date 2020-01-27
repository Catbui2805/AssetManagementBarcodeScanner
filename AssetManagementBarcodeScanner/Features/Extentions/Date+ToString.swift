//
//  Date+ToString.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/28/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
