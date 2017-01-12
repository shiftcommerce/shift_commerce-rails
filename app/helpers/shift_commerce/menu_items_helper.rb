module ShiftCommerce
  module MenuItemsHelper
    def menu_items_for(menu_reference, &blk)
      @__shiftcommerce_rails_cache ||= {}
      @__shiftcommerce_rails_cache[:menus] ||= {}
      menu = ::FlexCommerce::Menu.find("reference:#{menu_reference}")
      return if menu.nil?
      @__shiftcommerce_rails_cache[:menus].merge!(menu_reference => menu)
      menu.menu_items.each(&blk)
    end

    def url_for_menu_item(menu_item)
      return "/#{menu_item.path}"
    end
  end
end
