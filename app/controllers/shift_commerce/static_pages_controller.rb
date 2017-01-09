module ShiftCommerce
  class StaticPagesController < ::ApplicationController

    include ShiftCommerce::TemplateDefinitionHelper
    cache_shared_page only: :show

    API_STATIC_PAGE_INCLUDES = "template_definition,meta.*".freeze

    def show
      fetch_static_page
      set_static_page_meta_tags
      render_static_page
    end

    private

    def fetch_static_page
      @static_page = ::FlexCommerce::StaticPage.includes(API_STATIC_PAGE_INCLUDES).find(params[:id]).first
    end

    def set_static_page_meta_tags
      set_meta_tags title: @static_page.meta_attribute(:meta_title_override) || @static_page.title,
                    canonical: generate_absolute_url_for(@static_page.slug),
                    description: @static_page.meta_attribute(:meta_description),
                    keywords: @static_page.meta_attribute(:keywords)
    end

    def render_static_page
      if @static_page.published == true
        render_template_for @static_page
      else
        handle_resource_not_found
      end
    end

  end
end
