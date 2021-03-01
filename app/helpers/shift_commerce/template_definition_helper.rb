module ShiftCommerce
  module TemplateDefinitionHelper
    def render_template_for(item, *args)
      if item.template.present?
        if minimal_layout?
          render "template_definitions/#{item.template.reference}", *args, layout: false
        else
          render "template_definitions/#{item.template.reference}", *args, layout: true
        end
      else
        render *args
      end
    end

    def minimal_layout?
      request.headers['X-PJAX'.freeze] || params[:minimal]
    end
  end
end
