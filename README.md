# TKCurrencyTextField
TKCurrencyTextField is a UITextField component that makes the currency string mask of the current or fixed locale.

## Example
To run the example project, clone the repo and open `TKCurrencyTextField.xcodeproj`.

![](https://github.com/tokenlab/TKCurrencyTextField/blob/readme/Screenshots/Example.gif)

## Requirements
* Swift 3
* Deployment target 8.0


## Installation
### Carthage
Simply add the following lines to your Cartfile:

```ruby
github 'tokenlab/TKCurrencyTextField', '~> 0.1'
```

### CocoaPods
TKCurrencyTextField is available through Tokenlab's [TKPodSpec](https://github.com/tokenlab/TKPodSpecs). To install
it, simply add the following lines to your Podfile:

```ruby
source 'https://github.com/tokenlab/TKPodSpecs'
pod 'TKCurrencyTextField', '~> 0.1'
```
>note: "~> 0.1" means that we want version 0.1 and the versions up to 1.0, not including 1.0 and higher.

## How to use
TKCurrencyTextField can be used simply setting custom class to UITextField.
e.g:


You can customize by Interface Builder or code.
e.g:

Example: set fixed locale to United States without currency symbol.

```swift
@IBOutlet weak var currencyTextField: TKCurrencyTextField!

override func viewDidLoad() {
    super.viewDidLoad()
    currencyTextField.locale = Locale(identifier: "en_US") // United States
    currencyTextField.currencySymbol = false
}
```

### Functions
To manually set an amount, use this function:
```swift
currencyTextField.setAmount(123.45)
```

To get textField amount as double:
```swift
let currency = currencytTextField.getAmount
```

## Default values:

| Definition                 | var               | type          |     value      |
|:--------------------------:|:-----------------:|:-------------:|:--------------:|
| Initial amount             | defaultValue      | Double        | 0.0            |
| Maximum number of digits   | maxDigits         | Int           | 14             |
| Show/Hide currency symbol  | currencySymbol    | Bool          | true           |
| Currency of the country    | locale            | Locale        | Locale.current |


## Authors
[Daniele Boscolo](https://github.com/damboscolo), danieleboscolo@tokenlab.com.br

[Wagner Silva](https://github.com/Wagnesio), wagnersilva@tokenlab.com.br

[Edson Bueno](https://github.com/EdsonBueno), edsonbueno@tokenlab.com.br

## License
TKCurrencyTextField is available under the MIT license. See the LICENSE file for more info.
