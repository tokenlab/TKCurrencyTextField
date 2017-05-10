//
//  ViewController.swift
//  Example
//
//  Created by Daniele Boscolo on 10/05/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import UIKit
import TKCurrencyTextField

class MainTableViewController: UITableViewController {

    @IBOutlet weak var secondCurrencyTextField: TKCurrencyTextField!
    @IBOutlet weak var thirdCurrencyTextField: TKCurrencyTextField!
    @IBOutlet weak var fourthCurrencyTextField: TKCurrencyTextField!
    @IBOutlet weak var fifthCurrencyTextField: TKCurrencyTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        secondCurrencyTextField.locale = Locale(identifier: "en_US") // United States
        thirdCurrencyTextField.locale = Locale(identifier: "en_GB") // United Kingdom
        fourthCurrencyTextField.locale = Locale(identifier: "pt_BR") // Brazil
        fifthCurrencyTextField.locale = Locale(identifier: "es_ES") // Spain
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

