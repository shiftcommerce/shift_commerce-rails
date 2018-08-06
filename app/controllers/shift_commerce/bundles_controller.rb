module ShiftCommerce
  class BundlesController < ::ApplicationController
    include ShiftCommerce::TemplateDefinitionHelper
    include ShiftCommerce::CheckCanonicalPath
    
    cache_shared_page

    API_BUNDLE_INCLUDES = [
      'meta.*',
      'asset_files',
      'bundle_groups',
      'bundle_groups.products',
      'bundle_groups.products.variants',
      'bundle_groups.products.asset_files'
    ].join(',').freeze

    API_BUNDLE_FIELDS = {
      bundles: [
        'name',
        'description',
        'reference',
        'slug',
        'canonical_path',
        'asset_files',
        'bundle_groups',
        'meta_attributes'
      ].join(',').freeze,
      asset_files: 's3_url'.freeze,
      products: [
        'reference',
        'title',
        'slug',
        'min_current_price',
        'max_current_price',
        'min_price',
        'max_price',
        'meta_attributes',
        'variants',
        'asset_files',
        'available_to_browse',
        'has_assets',
        'canonical_path',
        'rating'
      ].join(',').freeze,
      variants: [
        'title',
        'reference',
        'sku',
        'ewis_eligible',
        'stock_available_level',
        'current_price',
        'meta_attributes',
        'asset_files'
      ].join(',').freeze
    }.freeze

    before_action -> { check_canonical_path_for(bundle) }, only: :show

    def show
      if bundle&.asset_files.present?
        set_meta_tags title: bundle_page_title,
                    canonical: bundle_page_canonical,
                    description: bundle_page_description,
                    keywords: bundle.meta_attribute(:keywords)
        # removes from index if "noindex" option is selected
        if bundle.meta_attribute(:meta_robot_tag) == "noindex"
          set_meta_tags noindex: true
        end
        render_template_for bundle, locals: { bundle: bundle }
      else
        handle_resource_not_found
      end
    end

    private

    def bundle_page_title
      bundle.meta_attribute(:meta_title_override).presence || bundle.title
    end

    def bundle_page_description
      bundle.meta_attribute(:meta_description).presence || bundle.meta_attribute(:category_text).presence
    end

    def bundle_page_canonical
      canonical_path = bundle.meta_attribute(:meta_canonical_override).presence || bundle.canonical_path
      generate_absolute_url_for(canonical_path)
    end

    def bundle
      @bundle ||= ::FlexCommerce::Bundle.with_params(fields: API_BUNDLE_FIELDS).includes(API_BUNDLE_INCLUDES).find(params[:id]).first
    end

    def bundle_groups
      bundle.bundle_groups
    end

    def asset_files
      bundle.asset_files
    end

    def asset_file
      asset_files.first
    end

  end
end
