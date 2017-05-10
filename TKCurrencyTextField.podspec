Pod::Spec.new do |spec|
  spec.name = "RGB"
  spec.version = "0.1.0"
  spec.summary = "Sample framework to insert a currency text in text field."
  spec.homepage = "https://github.com/tokenlab/TKCurrencyTextField"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Tokenlab" => 'danieleboscolo@tokenlab.com.br' }

  spec.platform = :ios, "9.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/tokenlab/TKCurrencyTextField.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "TKCurrencyTextField/**/*.{h,swift}"
end
