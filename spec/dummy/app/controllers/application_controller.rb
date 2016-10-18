require "flex_commerce_api/api_base"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
