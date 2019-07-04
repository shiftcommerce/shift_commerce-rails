module ShiftCommerce
  class StaticPagesController < ::ApplicationController

    include ShiftCommerce::TemplateDefinitionHelper
    include ShiftCommerce::CheckCanonicalPath

    cache_shared_page only: :show

    API_STATIC_PAGE_INCLUDES = "template,meta.*".freeze

    before_action -> { check_canonical_path_for(static_page) }, only: :show

    def show
      set_static_page_meta_tags
      render_static_page
    end

    private

    def set_static_page_meta_tags
      set_meta_tags title: static_page_title,
                    canonical: static_page_canonical,
                    description: static_page_description,
                    keywords: static_page_keywords
      #removes the page from index if "noindex" option is selected
      if static_page.meta_attribute(:meta_robot_tag) == "noindex"
          set_meta_tags noindex: true
      end
    end

    def static_page_title
       static_page.meta_attribute(:meta_title_override).presence || static_page.title
    end

    def static_page_description
      static_page.meta_attribute(:meta_description).presence
    end

    def static_page_canonical
      canonical_path = static_page.meta_attribute(:meta_canonical_override).presence  || static_page.canonical_path
      generate_absolute_url_for(canonical_path)
    end

    def static_page_keywords
      static_page.meta_attribute(:keywords).presence
    end

    def render_static_page?
      static_page.published == true
    end
  
    def render_static_page
      if render_static_page?
        render_template_for static_page, locals: { static_page: static_page }
      else
        handle_resource_not_found
      end
    end

    def static_page
      @static_page ||= ::FlexCommerce::StaticPage.includes(API_STATIC_PAGE_INCLUDES).find(params[:id]).first
    end

  end
end
