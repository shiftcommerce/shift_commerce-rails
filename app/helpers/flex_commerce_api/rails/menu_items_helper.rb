module FlexCommerceApi
  module Rails
    module MenuItemsHelper
      def menu_items_for(menu_reference, &blk)
        @__flex_commerce_api_rails_cache ||= {}
        @__flex_commerce_api_rails_cache[:menus] ||= {}
        menu = ::FlexCommerce::Menu.find(menu_reference)
        return if menu.nil?
        @__flex_commerce_api_rails_cache[:menus].merge!(menu_reference => menu)
        menu.menu_items.each(&blk)
      end

      def url_for_menu_item(menu_item)
        item = menu_item.item
        case item.class.to_s
          when "FlexCommerce::Product" then "/products/#{item.slug}"
          when "FlexCommerce::StaticPage" then pages_path slug: item.slug
          when "FlexCommerce::Category" then "/categories/#{item.slug}"
          else raise "Item #{item.class} is not defined in menu_items helper - so unable to calculate url"
        end


      end
    end
  end
end
