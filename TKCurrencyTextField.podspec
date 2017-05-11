Pod::Spec.new do |s|
  s.name = "TKCurrencyTextField"
  s.version = "1.0"
  s.summary = "TKCurrencyTextField is a UITextField component that makes the currency string mask of the current or fixed locale."
  s.homepage = "https://github.com/tokenlab/TKCurrencyTextField"
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.authors = {  "Daniele Boscolo" => 'danieleboscolo@tokenlab.com.br' }

  s.ios.deployment_target = '8.0'
  s.source = { :git => 'https://github.com/tokenlab/TKCurrencyTextField.git', :tag => s.version.to_s }
  s.source_files = "TKCurrencyTextField/**/*.{h,swift}"
end
