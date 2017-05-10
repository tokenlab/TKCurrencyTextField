//
//  Double+Currency.swift
//  Tokenlab
//
//  Created by Daniele Boscolo on 10/05/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import Foundation

extension Double {
    public var currencyStringValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
