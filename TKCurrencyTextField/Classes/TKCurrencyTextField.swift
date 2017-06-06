//
//  TKCurrencyTextField.swift
//  Tokenlab
//
//  Created by Daniele Boscolo on 10/05/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import UIKit

public protocol TKCurrencyTextFieldMixin {
    var amount: Double {get set}
    var maxDigits: Int {get set}
    var defaultValue: Double {get set}
    var currencySymbol: Bool {get set}
    var locale: Locale {get set}
    
    func textDidChange()
    func initTextField()
    func setAmount(_ amount: Double)
    func getAmount() -> Double
    func cannotPerformPastCopyAndCutAction(_ action: Selector, withSender sender: Any?) -> Bool
}

public extension TKCurrencyTextFieldMixin where Self: UITextField {
    
    func getAmount() -> Double {
        if let text = text {
            return text.currencyStringToDouble(with: locale)
        }
        return defaultValue
    }
    
    func setAmount(_ amount: Double) {
        let textFieldStringValue = amount.currencyStringValue(with: locale, currencySymbol)
        text = textFieldStringValue
        textDidChange()
    }
    
    func textDidChange() {
        let maskHandler: ReplacementStringHandler = {
            (textField, range, replacementString) in
            let nsString: NSString = textField.text as NSString? ?? ""
            let text = nsString.replacingCharacters(in: range, with: replacementString)
            
            //Remove mask from newText
            var cleanNumericString: String = text.onlyNumberString
            var textFieldNumber: Double = 0.0
            
            //Check if currency symbol was replaced
            // In case currency symbol was replaced, erase last character
            let formatter:NumberFormatter = NumberFormatter()
            formatter.locale = self.locale
            formatter.numberStyle = .currency
            if self.currencySymbol && !text.contains(formatter.currencySymbol) && cleanNumericString.characters.count > 0 {
                let lastIndex: String.Index = cleanNumericString.endIndex;
                cleanNumericString = cleanNumericString.substring(to: cleanNumericString.index(before: lastIndex))
            }
            
            //Checks if number of digits exceeded max
            if cleanNumericString.characters.count > self.maxDigits {
                let limitString = cleanNumericString.substring(to: cleanNumericString.characters.index(cleanNumericString.startIndex, offsetBy: self.maxDigits))
                textFieldNumber = (limitString as NSString).doubleValue
            } else {
                textFieldNumber = (cleanNumericString as NSString).doubleValue
            }
            
            //Applies mask
            let textFieldNewValue = textFieldNumber/100
            let textFieldStringValue = textFieldNewValue.currencyStringValue(with: self.locale, self.currencySymbol)
            self.text = textFieldStringValue
        }
        maskHandler(self, NSRange(), "")
    }
    
    func initTextField() {
        keyboardType = .decimalPad
        setAmount(defaultValue)
    }
    
    func closestPosition(to point: CGPoint) -> UITextPosition? {
        let beginning:UITextPosition = self.beginningOfDocument
        let end:UITextPosition? = self.position(from: beginning, offset: self.text?.characters.count ?? 0)
        return end
    }
    
    func cannotPerformPastCopyAndCutAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UITextField.paste(_:))
            || action == #selector(UITextField.copy(_:))
            || action == #selector(UITextField.cut(_:)) {
            return false
        }
        return true
    }
}

public typealias ReplacementString = String
public typealias ReplacementStringHandler = (UITextField, NSRange, ReplacementString) -> () // Can be used on textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool

@IBDesignable open class TKCurrencyTextField: UITextField, TKCurrencyTextFieldMixin {
    
    // MARK:- Public
    
    public var amount: Double {
        get {
            return getAmount()
        }
        set {
            setAmount(newValue)
        }
    }
    
    @IBInspectable public var maxDigits: Int = 15
    @IBInspectable public var defaultValue: Double = 0.00 {
        didSet {
            self.textDidChange()
        }
    }
    
    @IBInspectable public var currencySymbol: Bool = true {
        didSet {
            self.textDidChange()
        }
    }
    
    public var locale: Locale = Locale.current {
        didSet {
            self.textDidChange()
        }
    }
    
    // MARK: - init functions
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initTextField()
        addTarget()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initTextField()
        addTarget()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        initTextField()
        addTarget()
    }
    
    func addTarget() {
        addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    @objc func editingChanged(_ sender: Any?) {
        textDidChange()
    }
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return cannotPerformPastCopyAndCutAction(action, withSender: sender)
    }
}
