//
//  String+Number.swift
//  Tokenlab
//
//  Created by Daniele Boscolo on 10/05/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import Foundation

extension String {
    var onlyNumberString: String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }

    func currencyStringToDouble(with locale: Locale) -> Double {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.number(from: self) as? Double ?? 0.0
    }
}
