require 'shift_commerce/version'

module ShiftCommerce
  autoload :BetterErrorPage, File.expand_path(File.join('better_error_page'), __dir__)
end

require 'shift_commerce/engine'
