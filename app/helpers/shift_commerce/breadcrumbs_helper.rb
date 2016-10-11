module ShiftCommerce
  module BreadcrumbsHelper
    def breadcrumb_for(instance, menu_reference, &blk)
      @__shiftcommerce_rails_cache ||= {}
      @__shiftcommerce_rails_cache[:breadcrumbs] ||= {}
      menu = instance.breadcrumbs.find(menu_reference)
      return if menu.nil?
      @__shiftcommerce_rails_cache[:breadcrumbs].merge!(menu_reference => menu)
      menu.breadcrumb_items.each(&blk)
    end
  end
end
