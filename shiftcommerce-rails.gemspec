$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shift_commerce/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name          = "shiftcommerce-rails"
  spec.version       = ShiftCommerce::VERSION
  spec.authors       = ["Gary Taylor", "Ryan Townsend", "Peter Hicks"]
  spec.email         = ["gary.taylor@hismessages.com",
                        "ryan@ryantownsend.co.uk",
                        "peter@flock.im"]

  spec.summary       = "Standard Rails engine for building Shift front-end websites"
  spec.description   = "Standard Rails engine for building Shift front-end websites"
  spec.homepage      = "https://shiftcommerce.com/"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.add_dependency "rails", "~> 4.2.7"

  spec.add_development_dependency "rspec-rails", "~> 3.3"

  spec.add_runtime_dependency "activemerchant", "~> 1.54"
end