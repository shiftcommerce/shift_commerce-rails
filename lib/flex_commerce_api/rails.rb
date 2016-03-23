require "flex_commerce_api/rails/version"

module FlexCommerceApi
  module Rails
    autoload :BetterErrorPage, File.expand_path(File.join("rails", "better_error_page"), __dir__)
    # Your code goes here...

  end
end
require "flex_commerce_api/rails/engine"
