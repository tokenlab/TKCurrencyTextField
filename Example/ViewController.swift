//
//  ViewController.swift
//  Example
//
//  Created by Daniele Boscolo on 10/05/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import UIKit
import TKCurrencyTextField

class ViewController: UIViewController {

    @IBOutlet weak var firstCurrencyTextField: TKCurrencyTextField!
    @IBOutlet weak var secondCurrencyTextField: TKCurrencyTextField!
    @IBOutlet weak var thirdCurrencyTextField: TKCurrencyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondCurrencyTextField.locale = Locale(identifier: "en_GB") // United Kingdom
        thirdCurrencyTextField.locale = Locale(identifier: "pt_BR") // Brazil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

