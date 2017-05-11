//
//  TKCurrencyTextFieldTests.swift
//  TKCurrencyTextFieldTests
//
//  Created by Daniele Boscolo on 10/05/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import XCTest
@testable import TKCurrencyTextField

class TKCurrencyTextFieldTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLocale_en_US() {
        let currencyTextField = TKCurrencyTextField()
        currencyTextField.locale = Locale(identifier: "en_US")
        currencyTextField.setAmount(1000.49)
        XCTAssert(currencyTextField.text == "$1,000.49")
    }
    
    func testLocale_en_US_noCurrencySymbol() {
        let currencyTextField = TKCurrencyTextField()
        currencyTextField.locale = Locale(identifier: "pt_BR")
        currencyTextField.currencySymbol = false
        currencyTextField.setAmount(1000.49)
        XCTAssert(currencyTextField.text == "1.000,49")
    }
    
    func testLocale_pt_BR() {
        let currencyTextField = TKCurrencyTextField()
        currencyTextField.locale = Locale(identifier: "pt_BR")
        currencyTextField.setAmount(1000.49)
        XCTAssert(currencyTextField.text == "R$1.000,49")
    }
    
    func testLocale_pt_BR_noCurrencySymbol() {
        let currencyTextField = TKCurrencyTextField()
        currencyTextField.locale = Locale(identifier: "pt_BR")
        currencyTextField.currencySymbol = false
        currencyTextField.setAmount(1000.49)
        XCTAssert(currencyTextField.text == "1.000,49")
    }
    
    func testLocale_en_GB() {
        let currencyTextField = TKCurrencyTextField()
        currencyTextField.locale = Locale(identifier: "en_GB")
        currencyTextField.setAmount(2199999.21)
        XCTAssert(currencyTextField.text == "£2,199,999.21")
    }
    
    func testLocale_en_GB_noCurrencySymbol() {
        let currencyTextField = TKCurrencyTextField()
        currencyTextField.locale = Locale(identifier: "en_GB")
        currencyTextField.currencySymbol = false
        currencyTextField.setAmount(2199999.22)
        XCTAssert(currencyTextField.text == "2,199,999.22")
    }
    
    func testLocale_es_ES() {
        let currencyTextField = TKCurrencyTextField()
        currencyTextField.locale = Locale(identifier: "es_ES")
        currencyTextField.setAmount(1234.56)
        XCTAssert(currencyTextField.text == "1.234,56 €")
    }
    
    func testLocale_es_ES_noCurrencySymbol() {
        let currencyTextField = TKCurrencyTextField()
        currencyTextField.locale = Locale(identifier: "es_ES")
        currencyTextField.currencySymbol = false
        currencyTextField.setAmount(1234.56)
        XCTAssert(currencyTextField.text == "1.234,56 ")
    }
}
