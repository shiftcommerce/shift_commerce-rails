# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shift_commerce/version'

Gem::Specification.new do |spec|
  spec.name          = "shiftcommerce-rails"
  spec.version       = ShiftCommerce::VERSION
  spec.authors       = ["Gary Taylor", "Ryan Townsend"]
  spec.email         = ["gary.taylor@hismessages.com", "ryan@ryantownsend.co.uk"]

  spec.summary       = "Standard Rails engine for building Shift front-end websites"
  spec.description   = "Standard Rails engine for building Shift front-end websites"
  spec.homepage      = "https://shiftcommerce.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-rails", "~> 3.3"
  spec.add_runtime_dependency "activemerchant", "~> 1.54"
end
