module ShiftCommerce
  class StaticPagesController < ShiftCommerce::ApplicationController
    include ShiftCommerce::TemplateDefinitionHelper
    cache_shared_page only: :show

    API_STATIC_PAGE_INCLUDES = "template_definition,meta.*".freeze

    def show
      @static_page = fetch_static_page

      set_meta_tags title: static_page_title,
                    canonical: generate_absolute_url_for(@static_page.slug),
                    description: @static_page.meta_attribute(:meta_description),
                    keywords: @static_page.meta_attribute(:keywords)

      if @static_page.published == true
        if request.headers['X-PJAX'.freeze] || params[:minimal]
          render_template_for @static_page, layout: false
        else
          render_template_for @static_page
        end
      else
        handle_resource_not_found
      end
    end

    private

    def redirect_lookup_params
      if params[:slug_parts].present?
        { source_type: "static_pages".freeze, source_slug: params[:slug_parts] }
      else
        super
      end
    end

    def fetch_static_page
      ::FlexCommerce::StaticPage.includes(API_STATIC_PAGE_INCLUDES).find(params[:id]).first
    end

    def static_page_title
      @static_page.meta_attribute(:meta_title_override) || @static_page.title
    end
  end
end
