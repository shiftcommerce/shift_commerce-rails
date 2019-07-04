module ShiftCommerce
  module BundleHelper
    BUNDLE_CACHE_VERSION = "v1"

    def bundle_cache_version
      if defined?(Bundle) == 'constant' && Bundle.class == Class
        Bundle&.bundle_cache_version || BUNDLE_CACHE_VERSION
      else
        BUNDLE_CACHE_VERSION
      end
    end
  end
end