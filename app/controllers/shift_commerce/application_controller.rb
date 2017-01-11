module ShiftCommerce
  class ApplicationController < ActionController::Base
    include ShiftCommerce::HttpCaching
    include ShiftCommerce::PreviewStateManagement
    include ShiftCommerce::NotFoundRedirects
    include ShiftCommerce::AssetPush
    include ShiftCommerce::ResourceUrl
    include ShiftCommerce::ContentSecurityPolicy

    layout 'application'

    # Set the X-Cart-Id header on all requests with a cart_id session
    after_action :set_x_cart_id, unless: -> { request.get? || request.head? }

    PUSH_ASSETS = [
      'application.css'.freeze,
      'modernizr-custom.js'.freeze
    ].freeze

    # Prevent CSRF attacks by raising an exception.
    protect_from_forgery with: :exception

    # this overrides NotFoundRedirects#handle_not_found to provide site-wide nice 404 pages
    def handle_not_found(exception = nil)
      render "shared/not_found".freeze, status: 404
    end

    private

    # returns an array of assets to be pushed by HTTP/2
    def push_assets
      PUSH_ASSETS
    end

    # Sets the X-Cart-Id header
    def set_x_cart_id
      # Do not set on GET/HEAD requests
      # Only set when a cart is active
      if session[:cart_id].present?
        response.headers['X-Cart-Id'.freeze] = session[:cart_id]
      end
    end

  end
end
