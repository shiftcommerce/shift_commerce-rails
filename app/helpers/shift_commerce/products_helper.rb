module ShiftCommerce
  module ProductsHelper
    def product_price_for(product)
      if product.min_price == product.max_price
        "£ #{product.min_price}"
      else
        "£ #{product.min_price} - £ #{product.max_price}"
      end
    end

    def product_min_price_for(product)
      "£ #{product.min_price}"
    end

    def product_stock_level_for(product)
      product.variants.map(&:stock_level).sum
    end

    def product_extra_properties_for(product)
      core_attrs = ["title", "description", "min_price", "max_price", "slug", "reference", "relationships", "id", "type", "links"]
      product.attributes.reject {|key| core_attrs.include?(key.to_s) }
    end
  end
end
