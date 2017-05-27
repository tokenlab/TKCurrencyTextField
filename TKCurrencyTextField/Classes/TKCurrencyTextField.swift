//
//  TKCurrencyTextField.swift
//  Tokenlab
//
//  Created by Daniele Boscolo on 10/05/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import UIKit

@IBDesignable open class TKCurrencyTextField: UITextField {
    
    // MARK:- Public
    
    @IBInspectable public var maxDigits: Int = 15
    @IBInspectable public var defaultValue: Double = 0.00
    @IBInspectable public var currencySymbol: Bool = true
    public var locale: Locale = Locale.current {
        didSet {
            setAmount(defaultValue)
        }
    }
    
    public func setAmount (_ amount: Double) {
        let textFieldStringValue = amount.currencyStringValue(with: locale, currencySymbol)
        text = textFieldStringValue
    }
    
    public var getAmount: Double {
        if let text = text {
            return text.currencyStringToDouble(with: locale)
        }
        return defaultValue
    }
    
    // MARK:- Private vars
    
    private var _maskHandler: ((_ textField: UITextField, _ range: NSRange, _ replacementString: String) -> ())? = nil
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
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        initTextField()
    }
    
    private func initTextField(){
        let currencyHandler: ((_ textField: UITextField, _ range: NSRange, _ replacementString: String) -> ()) = {
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
            if !text.contains(formatter.currencySymbol) && cleanNumericString.characters.count > 0 {
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
    
    
    override open func closestPosition(to point: CGPoint) -> UITextPosition? {
        let beginning:UITextPosition = self.beginningOfDocument
        let end:UITextPosition? = self.position(from: beginning, offset: self.text?.characters.count ?? 0)
        return end
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
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(UITextField.paste(_:))
        || action == #selector(UITextField.copy(_:))
        || action == #selector(UITextField.cut(_:)) {
            return false
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
}
