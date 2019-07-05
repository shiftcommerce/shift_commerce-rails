# freeze_string_literal: true
module ShiftCommerce
  module StaticPageHelper
    STATIC_PAGE_CACHE_STATIC_VERSION = "v1"

    def static_page_cache_version
      self.STATIC_PAGE_CACHE_STATIC_VERSION
    end
  end
end