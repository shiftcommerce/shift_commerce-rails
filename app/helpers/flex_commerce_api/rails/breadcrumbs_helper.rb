module FlexCommerceApi
  module Rails
    module BreadcrumbsHelper
      def breadcrumb_for(instance, menu_reference, &blk)
        @__flex_commerce_api_rails_cache ||= {}
        @__flex_commerce_api_rails_cache[:breadcrumbs] ||= {}
        menu = instance.breadcrumbs.find(menu_reference)
        return if menu.nil?
        @__flex_commerce_api_rails_cache[:breadcrumbs].merge!(menu_reference => menu)
        menu.breadcrumb_items.each(&blk)
      end
    end
  end
end