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

    var currencyTextField: TKCurrencyTextField!

    override func setUp() {
        super.setUp()
        currencyTextField = TKCurrencyTextField()
    }
    
    override func tearDown() {
        super.tearDown()
        currencyTextField = nil
    }
    
    func testInitialValue() {
        currencyTextField.locale = Locale(identifier: "en_US")
        print("currencyTextField.text = \(currencyTextField.text ?? "")")
        XCTAssert(currencyTextField.text == "$0.00")
    }
    
    func testLocale_en_US() {
        currencyTextField.locale = Locale(identifier: "en_US")
        currencyTextField.amount = 1000.49
        print("currencyTextField.text = \(currencyTextField.text ?? "")")
        XCTAssert(currencyTextField.text == "$1,000.49")
    }
    
    func testLocale_en_US_noCurrencySymbol() {
        currencyTextField.locale = Locale(identifier: "pt_BR")
        currencyTextField.currencySymbol = false
        currencyTextField.amount = 1000.49
        XCTAssert(currencyTextField.text == "1.000,49")
    }
    
    func testLocale_pt_BR() {
        currencyTextField.locale = Locale(identifier: "pt_BR")
        currencyTextField.amount = 1000.49
        XCTAssert(currencyTextField.text == "R$1.000,49")
    }
    
    func testLocale_pt_BR_noCurrencySymbol() {
        currencyTextField.locale = Locale(identifier: "pt_BR")
        currencyTextField.currencySymbol = false
        currencyTextField.amount = 1000.49
        XCTAssert(currencyTextField.text == "1.000,49")
    }
    
    func testLocale_en_GB() {
        currencyTextField.locale = Locale(identifier: "en_GB")
        currencyTextField.amount = 2199999.21
        XCTAssert(currencyTextField.text == "£2,199,999.21")
    }
    
    func testLocale_en_GB_noCurrencySymbol() {
        currencyTextField.locale = Locale(identifier: "en_GB")
        currencyTextField.currencySymbol = false
        currencyTextField.amount = 2199999.22
        XCTAssert(currencyTextField.text == "2,199,999.22")
    }
    
    func testLocale_es_ES() {
        currencyTextField.locale = Locale(identifier: "es_ES")
        currencyTextField.amount = 1234.56
        XCTAssert(currencyTextField.text == "1.234,56 €")
    }
    
    func testLocale_es_ES_noCurrencySymbol() {
        currencyTextField.locale = Locale(identifier: "es_ES")
        currencyTextField.currencySymbol = false
        currencyTextField.amount = 1234.56
        XCTAssert(currencyTextField.text == "1.234,56 ")
    }
}
