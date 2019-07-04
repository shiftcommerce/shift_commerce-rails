module ShiftCommerce
  module StaticPageHelper
    STATIC_CACHE_VERSION = "v1"

    def static_page_cache_version
      if defined?(StaticPage) == 'constant' && StaticPage.class == Class
        StaticPage&.static_page_cache_version || STATIC_CACHE_VERSION
      else
        STATIC_CACHE_VERSION
      end
    end
  end
end