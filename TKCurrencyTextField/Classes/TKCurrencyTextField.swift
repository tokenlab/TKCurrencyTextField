//
//  TKCurrencyTextField.swift
//  Tokenlab
//
//  Created by Daniele Boscolo on 10/05/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import UIKit

public typealias ReplacementString = String
public typealias ReplacementStringHandler = (UITextField, NSRange, ReplacementString) -> () // Can be used on textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool

@IBDesignable open class TKCurrencyTextField: UITextField {
    
    // MARK:- Public
    
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
    
    public var amount: Double {
        get {
            if let text = text {
                return text.currencyStringToDouble(with: locale)
            }
            
            return defaultValue
        }
        
        set {
            let textFieldStringValue = amount.currencyStringValue(with: locale, currencySymbol)
            text = textFieldStringValue
        }
    }

    lazy var maskHandler: ReplacementStringHandler = {
        (textField, range, replacementString) in
        let nsString = NSString.init(string: textField.text ?? "")
        let text = nsString.replacingCharacters(in: range, with: replacementString)
        
        //Remove mask from newText
        var cleanNumericString = text.onlyNumberString
        var textFieldNumber:Double = 0.0
        
        //Check if currency symbol was replaced
        //In case currency symbol was replaced, erase last character
        let formatter = NumberFormatter()
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
        textField.text = textFieldStringValue
    }
    
    // MARK: - init functions
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initTextField()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initTextField()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        initTextField()
    }
    
    private func initTextField(){
        amount = defaultValue
        keyboardType = .decimalPad
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)

    }
    
    func textDidChange() {
        //Get the original position of the cursor
        maskHandler(self, NSRange(), "")
    }
    
    override open func closestPosition(to point: CGPoint) -> UITextPosition? {
        let beginning = self.beginningOfDocument
        let end = self.position(from: beginning, offset: self.text?.characters.count ?? 0)
        return end
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(UITextField.paste(_:))
        || action == #selector(UITextField.copy(_:))
        || action == #selector(UITextField.cut(_:)) {
            return false
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
}
