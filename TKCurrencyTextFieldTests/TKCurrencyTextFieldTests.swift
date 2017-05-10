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
    
    func testThousand() {
        let currencyTextField = TKCurrencyTextField()
        currencyTextField.setAmount(1000)
        XCTAssert(currencyTextField.text == "1,000.00")
    }
}
