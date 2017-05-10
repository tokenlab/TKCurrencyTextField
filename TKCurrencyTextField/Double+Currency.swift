//
//  Double+Currency.swift
//  Tokenlab
//
//  Created by Daniele Boscolo on 10/05/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import Foundation

extension Double {
    func currencyStringValue(with locale: Locale, _ isCurrencySymbolHidden: Bool) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        if isCurrencySymbolHidden {
            formatter.currencySymbol = ""
        }
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
