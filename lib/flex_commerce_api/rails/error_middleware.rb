require "json"
require "ipaddr"
require "set"
require "rack"
module FlexCommerceApi
  module Rails
    TEMPLATE_PATH = File.expand_path(File.join("error_templates"), __dir__)
    # Flex Commerce API error handling middleware. Including this in your middleware
    # stack will show the server side error from the platform when raised.
    #
    #
    class ErrorMiddleware
      # The set of IP addresses that are allowed to access the errors
      #
      # Set to `{ "127.0.0.1/8", "::1/128" }` by default.
      ALLOWED_IPS = Set.new

      # Adds an address to the set of IP addresses allowed to access Better
      # Errors.
      def self.allow_ip!(addr)
        ALLOWED_IPS << IPAddr.new(addr)
      end

      allow_ip! "127.0.0.0/8"
      allow_ip! "::1/128" rescue nil # windows ruby doesn't have ipv6 support

      # A new instance of FlexCommerceApi::Rails::ErrorMiddleware
      #
      # @param app      The Rack app/middleware to wrap
      def initialize(app)
        @app      = app
      end

      # Calls the Better Errors middleware
      #
      # @param [Hash] env
      # @return [Array]
      def call(env)
        if allow_ip? env
          call_with_rescue env
        else
          @app.call env
        end
      end

      private

      def allow_ip?(env)
        request = Rack::Request.new(env)
        return true unless request.ip and !request.ip.strip.empty?
        ip = IPAddr.new request.ip.split("%").first
        ALLOWED_IPS.any? { |subnet| subnet.include? ip }
      end

      def call_with_rescue(env)
        @app.call env
      rescue FlexCommerceApi::Error::Base => ex
        render_error_page(env, ex)
      end


      def render_error_page(env, exception=nil)
        status_code = 500
        template = ActionView::Base.new([TEMPLATE_PATH], exception: exception)
        file = "server_error"
        body = ""
        if text?(env)
          body = template.render(template: file, layout: false, formats: [:text]).to_str
          format = "text/plain"
        else
          body = template.render(template: file, layout: 'layout').to_str
          format = "text/html"
        end
        [status_code, {"Content-Type" => format} , [body]]
      end

      def text?(env)
        env["HTTP_X_REQUESTED_WITH"] == "XMLHttpRequest" ||
            !env["HTTP_ACCEPT"].to_s.include?('html')
      end
    end
  end
end
