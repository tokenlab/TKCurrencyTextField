# TKCurrencyTextField
[![CI Status](https://img.shields.io/travis/tokenlab/TKCurrencyTextField.svg?style=flat)](https://travis-ci.org/tokenlab/TKCurrencyTextField) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

TKCurrencyTextField is a UITextField component that makes the currency string mask of the current or fixed locale.

## Example
To run the example project, clone the repo and open `TKCurrencyTextField.xcodeproj`

![](https://github.com/tokenlab/TKCurrencyTextField/blob/master/Screenshots/Example.gif)

## Requirements
* Swift 3
* iOS 8.0 or higher


## Installation
### Carthage
Simply add the following lines to your Cartfile:

```ruby
github 'tokenlab/TKCurrencyTextField'
```

### CocoaPods
TKCurrencyTextField is available through Tokenlab's [TKPodSpec](https://github.com/tokenlab/TKPodSpecs). To install
it, simply add the following lines to your Podfile:

```ruby
pod 'TKCurrencyTextField', :git => 'https://github.com/tokenlab/TKPodSpecs.git'
```

## How to use
TKCurrencyTextField can be used simply setting custom class to UITextField:

![](https://github.com/tokenlab/TKCurrencyTextField/blob/master/Screenshots/CustomClass.png)

### Customization
You may customize by Interface Builder. E.g: Fixed locale to Brazil without currency symbol:

![](https://github.com/tokenlab/TKCurrencyTextField/blob/master/Screenshots/InspectableExample.png)

Or code:

```swift
@IBOutlet weak var currencyTextField: TKCurrencyTextField!

override func viewDidLoad() {
    super.viewDidLoad()
    currencyTextField.defaultValue = 100.00
    currencyTextField.maxDigits = 8
    currencyTextField.currencySymbol = false
    currencyTextField.locale = Locale(identifier: "pt_BR") // Brazil
}
```

### Functions
To manually set an amount, use this function:
```swift
currencyTextField.setAmount(123.45)
```

To get textField amount as Double:
```swift
let currency = currencytTextField.getAmount
```

### Default values

| Definition                 | var               | type          |     value      |
|:--------------------------:|:-----------------:|:-------------:|:--------------:|
| Initial amount             | defaultValue      | Double        | 0.0            |
| Maximum number of digits   | maxDigits         | Int           | 15             |
| Show/Hide currency symbol  | currencySymbol    | Bool          | true           |
| Currency of the country    | locale            | Locale        | Locale.current |


## Authors
[Daniele Boscolo](https://github.com/damboscolo), danieleboscolo@tokenlab.com.br

[Wagner Silva](https://github.com/Wagnesio), wagnersilva@tokenlab.com.br

[Edson Bueno](https://github.com/EdsonBueno), edsonbueno@tokenlab.com.br

## License
TKCurrencyTextField is available under the MIT license. See the LICENSE file for more info.
