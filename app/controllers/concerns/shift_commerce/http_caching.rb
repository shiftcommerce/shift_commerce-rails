# applies various headers for HTTP caching
module ShiftCommerce
  module HttpCaching
    extend ActiveSupport::Concern

    included do
      # all pages are private by default
      before_action :prevent_page_caching
    end

    class_methods do
      # applies page caching, but ensures we vary on Cookie so it won't be shared between users
      def cache_private_page(*args)
        cache_shared_page(*args)
        after_action :vary_page_caching_on_user, *args
      end

      # applies page caching, sharing the page across users
      def cache_shared_page(*args)
        around_action :capture_and_apply_surrogate_keys, *args
      end
    end

    protected

    # appends a private Cache-Control
    def prevent_page_caching
      response.headers['Cache-Control'] = 'private, max-age=0, must-revalidate'
    end

    # appends a Vary header instructing the caching to be unique to the session cookie
    def vary_page_caching_on_user
      response.headers['Vary'] = 'Cookie'
    end

    # capture Surrogate-Key values returned from any API requests and apply them
    # to this response's Surrogate-Key header
    def capture_and_apply_surrogate_keys
      surrogate_keys = FlexCommerceApi::ApiBase.capture_surrogate_keys do
        yield
      end

      if surrogate_keys.present? && ENV['FASTLY_ENABLE_ESI']
        response.headers['Surrogate-Key'] = surrogate_keys.split(' ').reject { |k| k.include?('menu_item') }.join(' ')
        response.headers['Surrogate-Control'] = 'max-age=3600,stale-if-error=86400,stale-while-revalidate=86400'
        response.headers['Cache-Control'] = 'max-age=0, must-revalidate'
      end
    end

  end
end
