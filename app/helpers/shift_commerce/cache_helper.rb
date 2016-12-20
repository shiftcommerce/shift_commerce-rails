module ShiftCommerce
  module CacheHelper
    def shift_cache object, *args
      return yield if object.nil?
      cache(shift_cache_key object, *args) { yield }
    end

    def menus_cache(reference)
      menu = all_menus_cache[reference] || MissingMenu.new(reference)
      return yield if menu.nil?
      multi_cache(shift_cache_key(menu)) { yield if block_given? }
    end

    private

    def shift_cache_key object
      [object.class.name, object.id, object.updated_at.to_datetime.utc.to_i.to_s].join("/")
    end
  end
end
