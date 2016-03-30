require "shift_commerce/rails/version"

module ShiftCommerce
  module Rails
    autoload :BetterErrorPage, File.expand_path(File.join("rails", "better_error_page"), __dir__)
    # Your code goes here...

  end
end
require "shift_commerce/rails/engine"
