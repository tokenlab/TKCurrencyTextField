//
//  TKCurrencyTextField.swift
//  Tokenlab
//
//  Created by Daniele Boscolo on 10/05/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import UIKit

@IBDesignable open class TKCurrencyTextField: UITextField {
    @IBInspectable var maxDigits: Int = 20
    @IBInspectable var defaultValue: Double = 0.00
    @IBInspectable var isCurrencySymbolHidden: Bool = false
    private var _maskHandler: ((_ textField: UITextField, _ range: NSRange, _ replacementString: String) -> ())? = nil

    public var locale: Locale = Locale.current {
        didSet {
            setAmount(defaultValue)
        }
    }

    var maskHandler: ((_ textField: UITextField, _ range: NSRange, _ replacementString: String) -> ())? {
        get {
            return _maskHandler
        }
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
    
    private func initTextField(){
        let currencyHandler: ((_ textField: UITextField, _ range: NSRange, _ replacementString: String) -> ()) = {
            (textField, range, replacementString) in
            let nsString: NSString = textField.text as NSString? ?? ""
            let text = nsString.replacingCharacters(in: range, with: replacementString)
            let cleanNumericString: String = text.onlyNumberString
            var textFieldNumber: Double = 0.0
            
            if cleanNumericString.characters.count > self.maxDigits {
                let limitString = cleanNumericString.substring(to: cleanNumericString.characters.index(cleanNumericString.startIndex, offsetBy: self.maxDigits))
                textFieldNumber = (limitString as NSString).doubleValue
            } else {
                textFieldNumber = (cleanNumericString as NSString).doubleValue
            }
            
            let textFieldNewValue = textFieldNumber/100
            let textFieldStringValue = textFieldNewValue.currencyStringValue(with: self.locale, self.isCurrencySymbolHidden)
            textField.text = textFieldStringValue
        }
        setMaskHandler(currencyHandler)
        setAmount(defaultValue)
        keyboardType = UIKeyboardType.decimalPad
    }
    
    public func setMaskHandler(_ handler: ((_ textField: UITextField, _ range: NSRange, _ replacementString: String)->())?) {
        _maskHandler = handler
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func textDidChange() {
        // get the original position of the cursor
        let cursorOffset = getOriginalCursorPosition();
        let textFieldLength = text?.characters.count
        maskHandler?(self, NSRange(), "")
        
        // set the cursor back to its original poistion
        setCursorOriginalPosition(cursorOffset, oldTextFieldLength: textFieldLength)
    }
    
    private func getOriginalCursorPosition() -> Int {
        var cursorOffset: Int = 0
        let startPosition: UITextPosition = self.beginningOfDocument
        if let selectedTextRange = self.selectedTextRange{
            cursorOffset = self.offset(from: startPosition, to: selectedTextRange.start)
        }
        return cursorOffset
    }
    
    private func setCursorOriginalPosition(_ cursorOffset: Int, oldTextFieldLength : Int?){
        let newLength = self.text?.characters.count
        let startPosition : UITextPosition = self.beginningOfDocument
        if let oldTextFieldLength = oldTextFieldLength, let newLength = newLength, oldTextFieldLength > cursorOffset {
            let newOffset = newLength - oldTextFieldLength + cursorOffset
            let newCursorPosition = self.position(from: startPosition, offset: newOffset)
            if let newCursorPosition = newCursorPosition{
                let newSelectedRange = self.textRange(from: newCursorPosition, to: newCursorPosition)
                self.selectedTextRange = newSelectedRange
            }
        }
    }
    
    // MARK: - Custom functions
    
    public func setAmount (_ amount: Double) {
        let textFieldStringValue = amount.currencyStringValue(with: locale, isCurrencySymbolHidden)
        text = textFieldStringValue
    }
    
    public var getAmount: Double {
        if let text = text {
            return text.currencyStringToDouble(with: locale)
        }
        return defaultValue
    }
}

