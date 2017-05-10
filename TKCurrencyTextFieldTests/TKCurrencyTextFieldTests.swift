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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
        currencyTextField.isCurrencySymbolHidden = true
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
        currencyTextField.isCurrencySymbolHidden = true
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
        currencyTextField.isCurrencySymbolHidden = true
        currencyTextField.setAmount(2199999.22)
        XCTAssert(currencyTextField.text == "2,199,999.22")
    }
}
