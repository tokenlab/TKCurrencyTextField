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

    var currencyStringToDouble: Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: self) as? Double ?? 0.0
    }
}
