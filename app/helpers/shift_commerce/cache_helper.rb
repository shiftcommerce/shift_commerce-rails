module ShiftCommerce
  module CacheHelper
    def shift_cache object, *args
      return yield if object.nil?
      cache(shift_cache_key object, *args) { yield }
    end

    def menus_cache(reference, banner_reference = nil, options = {})
      # Dont fetch from cache if requested for a preview
      return yield if params[:preview] === 'true'

      # Fetch from cache for normal requests
      menu = all_menus_cache[reference] || MissingMenu.new(reference)
      return yield if menu.nil?
      multi_cache(shift_cache_key(menu, banner_reference), options ) { yield if block_given? }
    end

    private

    def shift_cache_key(object, banner_reference = nil)
      object_id = banner_reference == nil ? object.id : banner_reference
      [object.class.name, object_id, object.updated_at.to_datetime.utc.to_i.to_s].join("/")
    end
  end
end
