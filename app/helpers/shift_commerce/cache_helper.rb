module ShiftCommerce
  module CacheHelper
    def shift_cache object, *args
      return yield if object.nil?
      cache(shift_cache_key object, *args) { yield }
    end

    def menus_cache(references, banner_reference = nil)
      # Dont fetch from cache if requested for a preview
      return yield if params[:preview] === 'true'

      menus = []
      Array(references).each do |reference|
        menus.push(all_menus_cache[reference] || MissingMenu.new(reference))
      end

      return yield if menus.nil?

      # Fetch from cache for normal requests
      if references.kind_of?(Array)
        multi_nested_cache(shift_cache_key(menus)) { yield if block_given? }
      else
        multi_cache(shift_cache_key(menus, banner_reference)) { yield if block_given? }
      end
    end
  
    private

    def shift_cache_key(object, banner_reference = nil)
      keys = []
      Array(object).each do |menu|
        object_id = banner_reference == nil ? menu.id : banner_reference
        keys.push(["FlexCommerce::Menu", object_id, menu.updated_at.to_datetime.utc.to_i.to_s].join("/"))
      end
      keys
    end

  end
end
